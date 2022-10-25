//
//  JSONDecoder.swift
//  OpenTweet
//
//  Created by Josh Roberts on 25/10/2022.
//

import Foundation

extension JSONDecoder {
    
    static let twitter: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }()
}
