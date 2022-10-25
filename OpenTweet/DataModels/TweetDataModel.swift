//
//  TweetDataModel.swift
//  OpenTweet
//
//  Created by Josh Roberts on 25/10/2022.
//

import Foundation

struct TweetDataModel: Decodable, Identifiable {
    let id: String
    let author: String
    let content: String
    let avatar: URL?
    let date: Date
    let inReplyTo: String?
}
