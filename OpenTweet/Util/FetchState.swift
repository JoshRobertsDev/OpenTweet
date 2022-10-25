//
//  FetchState.swift
//  OpenTweet
//
//  Created by Josh Roberts on 25/10/2022.
//

enum FetchState<Success, Failure> {
    case notInitiated
    case fetching
    case fetched(Success)
    case failed(Failure)
}
