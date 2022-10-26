//
//  TweetViewModelTests.swift
//  OpenTweetTests
//
//  Created by Josh Roberts on 25/10/2022.
//

import Combine
import XCTest

@testable import OpenTweet

final class OpenTweetTests: XCTestCase {
    
    let mockTweetService = MockTweetService()
    var tokens: Set<AnyCancellable> = []
    
    func testBasicProperties() {
        let viewModel = TweetViewModel(tweet: MockData.timeline[3], allTweets: MockData.timeline, tweetService: mockTweetService)
        
        XCTAssertEqual(viewModel.id, "00004")
        XCTAssertEqual(viewModel.author, "@ot_competitor")
        XCTAssertNil(viewModel.avatar)
        XCTAssertEqual(viewModel.replyingToTweet, "00042")
    }
    
    func testReplyingToIsCorrectlySet() {
        let viewModel1 = TweetViewModel(tweet: MockData.timeline[0], allTweets: MockData.timeline, tweetService: mockTweetService)
        XCTAssertNil(viewModel1.replyingTo)
        
        let viewModel2 = TweetViewModel(tweet: MockData.timeline[3], allTweets: MockData.timeline, tweetService: mockTweetService)
        XCTAssertEqual(viewModel2.replyingTo, "@olarivain")
    }
    
    func testContentIsModifiedCorrectly() {
        let viewModel1 = TweetViewModel(tweet: MockData.timeline[0], allTweets: MockData.timeline, tweetService: mockTweetService)
        XCTAssertEqual(viewModel1.content, "Man, I'm hungry. I probably should book a table at a restaurant or something. Wonder if there's an app for that?")
        
        let viewModel2 = TweetViewModel(tweet: MockData.timeline[3], allTweets: MockData.timeline, tweetService: mockTweetService)
        XCTAssertEqual(viewModel2.content, "Meh.")
    }
    
    func testContentRunAttributesIsCorrectlySet() {
        let viewModel1 = TweetViewModel(tweet: MockData.timeline[0], allTweets: MockData.timeline, tweetService: mockTweetService)
        XCTAssertTrue(viewModel1.contentRunAttributes.isEmpty)
        
        let viewModel2 = TweetViewModel(tweet: MockData.timeline[1], allTweets: MockData.timeline, tweetService: mockTweetService)
        
        if case .link(let range) = viewModel2.contentRunAttributes.first {
            XCTAssertEqual(range.location, 81)
            XCTAssertEqual(range.length, 58)
        } else {
            XCTFail()
        }
    }
    
    func testRepliesCountIsCorrectlyCalculated() {
        let viewModel1 = TweetViewModel(tweet: MockData.timeline[0], allTweets: MockData.timeline, tweetService: mockTweetService)
        XCTAssertEqual(viewModel1.repliesCount, 0)
        
        let viewModel2 = TweetViewModel(tweet: MockData.timeline[1], allTweets: MockData.timeline, tweetService: mockTweetService)
        XCTAssertEqual(viewModel2.repliesCount, 3)
    }
    
    func testDatePostedIsInCorrectFormatted() {
        let times: [(Calendar.Component, Int, String)] = [
            (.second, 1, "1s"),
            (.second, 2, "2s"),
            (.minute, 1, "1min"),
            (.minute, 2, "2mins"),
            (.hour, 1, "1h"),
            (.hour, 2, "2h"),
            (.day, 1, "1d"),
            (.day, 2, "2d"),
            (.day, 7, "1w"),
            (.day, 14, "2w"),
            (.month, 1, "1m"),
            (.month, 2, "2m"),
            (.year, 1, "1y"),
            (.year, 2, "2y"),
        ]
        
        times.forEach { component, value, string in
            let viewModel = TweetViewModel(
                tweet: TweetDataModel(
                    id: "1",
                    author: "",
                    content: "",
                    avatar: nil,
                    date: Calendar.current.date(byAdding: component, value: -1 * value, to: Date())!,
                    inReplyTo: nil
                ),
                allTweets: [],
                tweetService: mockTweetService
            )
            
            XCTAssertEqual(viewModel.datePosted, string)
        }
    }
    
    func testSuccessfulFetchReplies() {
        let mockComments = [MockData.timeline[4]]
        mockTweetService.fetchTweetRepliesResponse = CurrentValueSubject<[TweetDataModel], Error>(mockComments).eraseToAnyPublisher()
        let viewModel = TweetViewModel(tweet: MockData.timeline[3], allTweets: MockData.timeline, tweetService: mockTweetService)
        
        let expectation = expectation(description: "State should flow as notInitiated, fetching, fetched")
        
        viewModel.$replies
            .collect(3)
            .sink { states in
                XCTAssertTrue(states[0].isNotInitiated)
                XCTAssertTrue(states[1].isFetching)
                XCTAssertNotNil(states[2].fetchedValue)
                expectation.fulfill()
            }
            .store(in: &tokens)
        
        viewModel.fetchTweetReplies()
        
        waitForExpectations(timeout: 5)
    }
    
    func testFailedFetchReplies() throws {
        mockTweetService.fetchTweetRepliesResponse = Fail<[TweetDataModel], Error>(error: NSError(domain: "", code: 0) as Error).eraseToAnyPublisher()
        let viewModel = TweetViewModel(tweet: MockData.timeline[3], allTweets: MockData.timeline, tweetService: mockTweetService)
        
        let expectation = expectation(description: "State should flow as notInitiated, fetching, failed")
        
        viewModel.$replies
            .collect(3)
            .sink { states in
                XCTAssertTrue(states[0].isNotInitiated)
                XCTAssertTrue(states[1].isFetching)
                let errorMessage = states[2].error!
                XCTAssertEqual(errorMessage.title, "Unable to load replies")
                XCTAssertEqual(errorMessage.message, "Try again later")
                expectation.fulfill()
            }
            .store(in: &tokens)
        
        viewModel.fetchTweetReplies()
        
        waitForExpectations(timeout: 5)
    }
}
