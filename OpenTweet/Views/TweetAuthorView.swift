//
//  TweetAuthorView.swift
//  OpenTweet
//
//  Created by Josh Roberts on 25/10/2022.
//

import SwiftUI

struct TweetAuthorView: View {
    
    let author: String
    let datePosted: String
    
    var body: some View {
        HStack {
            Text(author)
                .font(.headline)
                .fontWeight(.semibold)
                .lineLimit(1)
            
            Spacer()
            
            Text(datePosted)
                .foregroundColor(.secondary)
                .font(.caption)
                .fontWeight(.semibold)
                .lineLimit(1)
        }
    }
}
struct TweetAuthorView_Previews: PreviewProvider {
    static var previews: some View {
        TweetAuthorView(author: "@josh", datePosted: "3h")
    }
}
