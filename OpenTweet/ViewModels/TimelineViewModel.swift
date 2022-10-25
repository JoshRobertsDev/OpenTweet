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
    
    @Published var tweets: [TweetViewModel] = []
    
    // MARK: - Private propertes
    
    private let tweetService: TweetService
    private var tokens: Set<AnyCancellable> = []
    
    // MARK: - Init
    
    init(tweetService: TweetService) {
        self.tweetService = tweetService
    }
    
    // MARK: - Public API
    
    func fetchTimeline() {
        tweetService.fetchTimeline()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in }, receiveValue: { [weak self] tweets in
                guard let self = self else { return }
                self.tweets = tweets.map { TweetViewModel(tweet: $0, allTweets: tweets, tweetService: self.tweetService) }
            })
            .store(in: &tokens)
    }
}
