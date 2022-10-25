//
//  RelativeDateTimeFormatter.swift
//  OpenTweet
//
//  Created by Josh Roberts on 25/10/2022.
//

import Foundation

extension RelativeDateTimeFormatter {
    
    static let timelineDateTimeFormatter: RelativeDateTimeFormatter = {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        return formatter
    }()
}
