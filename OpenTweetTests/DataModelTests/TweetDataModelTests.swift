//
//  TweetDataModelTests.swift
//  OpenTweetTests
//
//  Created by Josh Roberts on 26/10/2022.
//

import XCTest

@testable import OpenTweet

final class TweetDataModelTests: XCTestCase {

    func testMinimumDecoding() throws {
        let data = """
        {
          "id": "00004",
          "author": "@ot_competitor",
          "content": "@olarivain Meh.",
          "date": "2022-09-30T09:45:00-08:00"
        }
        """.data(using: .utf8)!
        
        let decoded = try JSONDecoder.twitter.decode(TweetDataModel.self, from: data)
        
        XCTAssertEqual(decoded.id, "00004")
        XCTAssertEqual(decoded.author, "@ot_competitor")
        XCTAssertEqual(decoded.content, "@olarivain Meh.")
        XCTAssertEqual(decoded.date, try Date("2022-09-30T09:45:00-08:00", strategy: .iso8601) )
    }
    
    func testMaximumDecoding() throws {
        let data = """
        {
          "id": "00003",
          "author": "@randomInternetStranger",
          "content": "@olarivain OMG where have YOU been all my life?",
          "avatar": "https://i.imgflip.com/ohrrn.jpg",
          "inReplyTo": "00042",
          "date": "2022-09-30T09:42:00-08:00"
        }
        """.data(using: .utf8)!
        
        let decoded = try JSONDecoder.twitter.decode(TweetDataModel.self, from: data)
        
        XCTAssertEqual(decoded.id, "00003")
        XCTAssertEqual(decoded.author, "@randomInternetStranger")
        XCTAssertEqual(decoded.avatar, URL(string: "https://i.imgflip.com/ohrrn.jpg")!)
        XCTAssertEqual(decoded.content, "@olarivain OMG where have YOU been all my life?")
        XCTAssertEqual(decoded.inReplyTo, "00042")
        XCTAssertEqual(decoded.date, try Date("2022-09-30T09:42:00-08:00", strategy: .iso8601) )
    }
}
