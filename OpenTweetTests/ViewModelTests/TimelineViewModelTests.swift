//
//  TimelineViewModelTests.swift
//  OpenTweetTests
//
//  Created by Josh Roberts on 26/10/2022.
//

import Combine
import XCTest

@testable import OpenTweet

final class TimelineViewModelTests: XCTestCase {
    
    let mockTweetService = MockTweetService()
    var tokens: Set<AnyCancellable> = []

    func testSuccessfulFetchReplies() {
        mockTweetService.fetchTimelineResponse = CurrentValueSubject<[TweetDataModel], Error>(MockData.timeline).eraseToAnyPublisher()
        let viewModel = TimelineViewModel(tweetService: mockTweetService)
        
        let expectation = expectation(description: "State should flow as notInitiated, fetching, fetched")
        
        viewModel.$state
            .collect(3)
            .sink { states in
                XCTAssertTrue(states[0].isNotInitiated)
                XCTAssertTrue(states[1].isFetching)
                XCTAssertEqual(states[2].fetchedValue?.count, 7)
                expectation.fulfill()
            }
            .store(in: &tokens)
        
        viewModel.fetchTimeline()
        
        waitForExpectations(timeout: 5)
    }
    
    func testFailedFetchReplies() throws {
        mockTweetService.fetchTimelineResponse = Fail<[TweetDataModel], Error>(error: NSError(domain: "", code: 0) as Error).eraseToAnyPublisher()
        let viewModel = TimelineViewModel(tweetService: mockTweetService)
        
        let expectation = expectation(description: "State should flow as notInitiated, fetching, failed")
        
        viewModel.$state
            .collect(3)
            .sink { states in
                XCTAssertTrue(states[0].isNotInitiated)
                XCTAssertTrue(states[1].isFetching)
                let errorMessage = states[2].error!
                XCTAssertEqual(errorMessage.title, "Unable to load timeline")
                XCTAssertEqual(errorMessage.message, "Try again later")
                expectation.fulfill()
            }
            .store(in: &tokens)
        
        viewModel.fetchTimeline()
        
        waitForExpectations(timeout: 5)
    }
}
