//
//  TweetContentView.swift
//  OpenTweet
//
//  Created by Josh Roberts on 25/10/2022.
//

import SwiftUI

struct TweetContentView: View {
    
    let content: String
    
    var body: some View {
        Text(content)
            .font(.body)
            .fontWeight(.regular)
            .textSelection(.enabled)
    }
}

struct TweetContentView_Previews: PreviewProvider {
    static var previews: some View {
        TweetContentView(content: "Hi! This is a dummy tweet")
    }
}
