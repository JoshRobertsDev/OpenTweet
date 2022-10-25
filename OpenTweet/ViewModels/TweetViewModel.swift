//
//  TweetViewModel.swift
//  OpenTweet
//
//  Created by Josh Roberts on 25/10/2022.
//

import Combine
import Foundation

class TweetViewModel: ObservableObject, Identifiable {
    
    // MARK: - Public properties
    
    let id: String
    let author: String
    let content: String
    let avatar: URL?
    let datePosted: String
    let replyingToTweet: String?
    let replyingTo: String?
    let replies: Int
    
    // MARK: - Init
    
    init(tweet: TweetDataModel, allTweets: [TweetDataModel]) {
        self.id = tweet.id
        self.author = tweet.author
        self.content = tweet.content
        self.avatar = tweet.avatar
        self.replyingTo = allTweets.first { $0.id == tweet.inReplyTo }?.author
        self.replyingToTweet = allTweets.first { $0.id == tweet.inReplyTo }?.id
        self.replies = allTweets.filter { $0.inReplyTo == tweet.id }.count
        
        // Quick workaround to show a very short relative date - a production version would need more work
        self.datePosted = RelativeDateTimeFormatter.timelineDateTimeFormatter.localizedString(for: tweet.date, relativeTo: .now)
            .replacingOccurrences(of: " seconds", with: "s")
            .replacingOccurrences(of: "minutes", with: "mins")
            .replacingOccurrences(of: " hours", with: "h")
            .replacingOccurrences(of: " days", with: "d")
            .replacingOccurrences(of: " weeks", with: "w")
            .replacingOccurrences(of: " months", with: "m")
            .replacingOccurrences(of: " years", with: "y")
            .replacingOccurrences(of: "ago", with: "")
    }
}
