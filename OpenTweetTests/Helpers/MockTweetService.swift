//
//  MockTweetService.swift
//  OpenTweetTests
//
//  Created by Josh Roberts on 25/10/2022.
//

import Combine

@testable import OpenTweet

final class MockTweetService: TweetService {
    
    var fetchTimelineResponse: AnyPublisher<[TweetDataModel], Error>?
    var fetchTweetRepliesResponse: AnyPublisher<[TweetDataModel], Error>?
    
    override func fetchTimeline() -> AnyPublisher<[TweetDataModel], Error> {
        return fetchTimelineResponse!
    }
    
    override func fetchTweetReplies(forTweetId id: String) -> AnyPublisher<[TweetDataModel], Error> {
        return fetchTweetRepliesResponse!
    }
}
