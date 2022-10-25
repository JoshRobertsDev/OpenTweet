//
//  TweetService.swift
//  OpenTweet
//
//  Created by Josh Roberts on 25/10/2022.
//

import Combine
import Foundation

class TweetService {
    
    func fetchTimeline() -> AnyPublisher<[TweetDataModel], Error> {
        CurrentValueSubject<[TweetDataModel], Error>(MockData.timeline).eraseToAnyPublisher()
    }
}
