//
//  TweetContentView.swift
//  OpenTweet
//
//  Created by Josh Roberts on 25/10/2022.
//

import SwiftUI

struct TweetContentView: View {
    
    let content: String
    let contentRunAttributes: [TweetViewModel.ContentRunAttributes]
    
    var body: some View {
        Text(attributedTweetString())
            .font(.body)
            .fontWeight(.regular)
            .textSelection(.enabled)
    }
    
    private func attributedTweetString() -> AttributedString {
        var attributedString = AttributedString(stringLiteral: content)
        
        contentRunAttributes.forEach {
            switch $0 {
            case .link(let range):
                let attributedRange = Range(range, in: attributedString)!
                attributedString[attributedRange].foregroundColor = .cyan
                attributedString[attributedRange].underlineStyle = .single
            case .mention(let range):
                if let attributedRange = Range(range, in: attributedString) {
                    attributedString[attributedRange].foregroundColor = .cyan
                }
            }
        }
        
        return attributedString
    }
}

struct TweetContentView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            TweetContentView(content: "Hi! This is a dummy tweet", contentRunAttributes: [])
            TweetContentView(content: "Hi! This is a dummy tweet https://www.opentable.com", contentRunAttributes: [.link(range: NSRange(location: 26, length: 25))])
            TweetContentView(content: "Hi @Josh! This is a dummy tweet", contentRunAttributes: [.mention(range: NSRange(location: 3, length: 5))])
        }
    }
}
