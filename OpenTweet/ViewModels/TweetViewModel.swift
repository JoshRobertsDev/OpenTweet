//
//  TweetViewModel.swift
//  OpenTweet
//
//  Created by Josh Roberts on 25/10/2022.
//

import Combine
import Foundation

class TweetViewModel: ObservableObject, Identifiable {
    
    // MARK: - Public properties
    
    let id: String
    let author: String
    let content: String
    let contentRunAttributes: [ContentRunAttributes]
    let avatar: URL?
    let datePosted: String
    let replyingToTweet: String?
    let replyingTo: String?
    let repliesCount: Int
    @Published private(set) var replies: FetchState<[TweetViewModel], ErrorMessage> = .notInitiated
    
    // MARK: - Private properties
    
    private let tweetService: TweetService
    private var tokens: Set<AnyCancellable> = []
    
    // MARK: - Init
    
    init(tweet: TweetDataModel, allTweets: [TweetDataModel], tweetService: TweetService) {
        self.id = tweet.id
        self.author = tweet.author
        self.avatar = tweet.avatar
        
        let replyingTo = allTweets.first { $0.id == tweet.inReplyTo }?.author
        
        var content = tweet.content
        
        if let replyingTo = replyingTo, content.hasPrefix(replyingTo + " ") {
            content = String(content.dropFirst(replyingTo.count + 1))
        }
        
        self.content = content
        
        var contentRunAttributes = [ContentRunAttributes]()
        
        if let detector = try? NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue) {
            let range = NSRange(location: 0, length: content.count)
            
            detector
                .matches(in: content, options: [], range: range)
                .forEach { contentRunAttributes.append(ContentRunAttributes.link(range: $0.range)) }
        }
        
        if let replyingTo = replyingTo, let regex = try? NSRegularExpression(pattern: replyingTo) {
            let range = NSRange(content.startIndex..<content.endIndex, in: content)
            
            regex
                .matches(in: content, range: range)
                .forEach { contentRunAttributes.append(ContentRunAttributes.mention(range: $0.range)) }
        }
        
        self.contentRunAttributes = contentRunAttributes
        
        self.replyingTo = replyingTo
        self.replyingToTweet = allTweets.first { $0.id == tweet.inReplyTo }?.id
        self.repliesCount = allTweets.filter { $0.inReplyTo == tweet.id }.count
        self.datePosted = TweetDateFormatter.string(from: tweet.date)
        self.tweetService = tweetService
    }
    
    // MARK: - Public API
    
    func fetchTweetReplies() {
        replies = .fetching
        
        tweetService.fetchTweetReplies(forTweetId: id)
            .debounce(for: 1, scheduler: DispatchQueue.main) // Add artificial delay to simulating loading from network
            .mapError { ErrorMessage(error: $0) }
            .sink(receiveCompletion: { [weak self] in
                if case .failure(let errorMessage) = $0 {
                    self?.replies = .failed(errorMessage)
                }
            }, receiveValue: { [weak self] tweets in
                guard let self = self else { return }
                
                let viewModels = tweets
                    .filter { $0.inReplyTo == self.id }
                    .map { TweetViewModel(tweet: $0, allTweets: tweets, tweetService: self.tweetService) }
                
                self.replies = .fetched(viewModels)
            })
            .store(in: &tokens)
    }
}

extension TweetViewModel {
    
    enum ContentRunAttributes {
        case link(range: NSRange)
        case mention(range: NSRange)
    }
}

private extension ErrorMessage {
    
    init(error: Error) {
        self.init(
            title: "Unable to load timeline",
            message: "Try again later"
        )
    }
}
