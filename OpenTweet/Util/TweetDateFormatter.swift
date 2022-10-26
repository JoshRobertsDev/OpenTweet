//
//  RelativeDateFormatter.swift
//  OpenTweet
//
//  Created by Josh Roberts on 26/10/2022.
//

import Foundation

enum TweetDateFormatter {
    
    static func string(from date: Date) -> String {
        // Quick workaround to show a very short relative date - a production version would need more work
        return RelativeDateTimeFormatter.timelineDateTimeFormatter.localizedString(for: date, relativeTo: .now)
            .replacingOccurrences(of: " seconds", with: "s")
            .replacingOccurrences(of: " second", with: "s")
            .replacingOccurrences(of: " minutes", with: "mins")
            .replacingOccurrences(of: " minute", with: "min")
            .replacingOccurrences(of: " hours", with: "h")
            .replacingOccurrences(of: " hour", with: "h")
            .replacingOccurrences(of: " days", with: "d")
            .replacingOccurrences(of: " day", with: "d")
            .replacingOccurrences(of: " weeks", with: "w")
            .replacingOccurrences(of: " week", with: "w")
            .replacingOccurrences(of: " months", with: "m")
            .replacingOccurrences(of: " month", with: "m")
            .replacingOccurrences(of: " years", with: "y")
            .replacingOccurrences(of: " year", with: "y")
            .replacingOccurrences(of: " ago", with: "")
    }
}
