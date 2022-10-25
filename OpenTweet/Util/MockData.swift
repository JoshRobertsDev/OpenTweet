//
//  MockData.swift
//  OpenTweet
//
//  Created by Josh Roberts on 25/10/2022.
//

import Foundation

enum MockData {
    
    static let timeline: [TweetDataModel] = {
        guard
            let url = Bundle.main.url(forResource: "timeline", withExtension: "json"),
            let data = try? Data(contentsOf: url),
            let decoded = try? JSONDecoder.twitter.decode(TimelineDataModel.self, from: data)
        else {
            return []
        }
        
        return decoded.timeline
    }()
}
