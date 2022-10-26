//
//  TimelineDataModelTests.swift
//  OpenTweetTests
//
//  Created by Josh Roberts on 26/10/2022.
//

import XCTest

@testable import OpenTweet

final class TimelineDataModelTests: XCTestCase {

    func testMinimumDecoding() throws {
        let data = """
        {
          "timeline": []
        }
        """.data(using: .utf8)!
        
        let decoded = try JSONDecoder.twitter.decode(TimelineDataModel.self, from: data)
        
        XCTAssertTrue(decoded.timeline.isEmpty)
    }
    
    func testMaximumDecoding() throws {
        let data = """
        {
            "timeline": [
                {
                  "id": "00003",
                  "author": "@randomInternetStranger",
                  "content": "@olarivain OMG where have YOU been all my life?",
                  "avatar": "https://i.imgflip.com/ohrrn.jpg",
                  "inReplyTo": "00042",
                  "date": "2022-09-30T09:42:00-08:00"
                }
            ]
        }
        
        """.data(using: .utf8)!
        
        let decoded = try JSONDecoder.twitter.decode(TimelineDataModel.self, from: data)
        
        XCTAssertFalse(decoded.timeline.isEmpty)
    }
}
