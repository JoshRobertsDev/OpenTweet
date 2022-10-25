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
    let avatar: URL?
    let datePosted: String
    let replyingToTweet: String?
    let replyingTo: String?
    let repliesCount: Int
    @Published private(set) var replies: [TweetViewModel] = []
    
    // MARK: - Private properties
    
    private let tweetService: TweetService
    private var tokens: Set<AnyCancellable> = []
    
    // MARK: - Init
    
    init(tweet: TweetDataModel, allTweets: [TweetDataModel], tweetService: TweetService) {
        self.id = tweet.id
        self.author = tweet.author
        self.content = tweet.content
        self.avatar = tweet.avatar
        self.replyingTo = allTweets.first { $0.id == tweet.inReplyTo }?.author
        self.replyingToTweet = allTweets.first { $0.id == tweet.inReplyTo }?.id
        self.repliesCount = allTweets.filter { $0.inReplyTo == tweet.id }.count
        
        // Quick workaround to show a very short relative date - a production version would need more work
        self.datePosted = RelativeDateTimeFormatter.timelineDateTimeFormatter.localizedString(for: tweet.date, relativeTo: .now)
            .replacingOccurrences(of: " seconds", with: "s")
            .replacingOccurrences(of: "minutes", with: "mins")
            .replacingOccurrences(of: " hours", with: "h")
            .replacingOccurrences(of: " days", with: "d")
            .replacingOccurrences(of: " weeks", with: "w")
            .replacingOccurrences(of: " months", with: "m")
            .replacingOccurrences(of: " years", with: "y")
            .replacingOccurrences(of: "ago", with: "")
        
        self.tweetService = tweetService
    }
    
    // MARK: - Public API
    
    func fetchTweetReplies() {
        tweetService.fetchTweetReplies(forTweetId: id)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in }, receiveValue: { [weak self] tweets in
                guard let self = self else { return }
                self.replies = tweets
                    .filter { $0.inReplyTo == self.id }
                    .map { TweetViewModel(tweet: $0, allTweets: tweets, tweetService: self.tweetService) }
            })
            .store(in: &tokens)
    }
}
