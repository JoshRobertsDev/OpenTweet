//
//  TimelineDataModel.swift
//  OpenTweet
//
//  Created by Josh Roberts on 25/10/2022.
//

struct TimelineDataModel: Decodable {
    let timeline: [TweetDataModel]
}
