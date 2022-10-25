//
//  TimelineViewModel.swift
//  OpenTweet
//
//  Created by Josh Roberts on 25/10/2022.
//

import Combine
import Foundation

class TimelineViewModel: ObservableObject {
    
    // MARK: - Public properties
    
    @Published private(set) var state: FetchState<[TweetViewModel], ErrorMessage> = .notInitiated
    
    // MARK: - Private propertes
    
    private let tweetService: TweetService
    private var tokens: Set<AnyCancellable> = []
    
    // MARK: - Init
    
    init(tweetService: TweetService) {
        self.tweetService = tweetService
    }
    
    // MARK: - Public API
    
    func fetchTimeline() {
        state = .fetching
        
        tweetService.fetchTimeline()
            .debounce(for: 0.5, scheduler: DispatchQueue.main) // Add artificial delay to simulating loading from network
            .mapError { ErrorMessage(error: $0) }
            .sink(receiveCompletion: { [weak self] in
                if case .failure(let error) = $0 {
                    self?.state = .failed(error)
                }
            }, receiveValue: { [weak self] tweets in
                guard let self = self else { return }
                self.state = .fetched(tweets.map { TweetViewModel(tweet: $0, allTweets: tweets, tweetService: self.tweetService) })
            })
            .store(in: &tokens)
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
