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
            .map { tweets in tweets.map { TweetViewModel(tweet: $0, allTweets: tweets) } }
            .sink(receiveCompletion: { _ in }, receiveValue: { [weak self] in self?.tweets = $0 })
            .store(in: &tokens)
    }
}
