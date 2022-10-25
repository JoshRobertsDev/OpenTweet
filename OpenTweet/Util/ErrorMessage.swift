//
//  ErrorMessage.swift
//  OpenTweet
//
//  Created by Josh Roberts on 25/10/2022.
//

import Foundation

struct ErrorMessage: Error {
    let title: String
    let message: String
}
