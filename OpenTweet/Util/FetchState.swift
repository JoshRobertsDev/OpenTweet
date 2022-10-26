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

extension FetchState: Equatable where Success: Equatable, Failure: Equatable {}

extension FetchState {
    
    var isNotInitiated: Bool {
        guard case .notInitiated = self else { return false }
        return true
    }
    
    var isFetching: Bool {
        guard case .fetching = self else { return false }
        return true
    }
    
    var fetchedValue: Success? {
        guard case .fetched(let value) = self else { return nil }
        return value
    }
    
    var error: Failure? {
        guard case .failed(let error) = self else { return nil }
        return error
    }
}
