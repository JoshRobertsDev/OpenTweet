//
//  TweetInfoView.swift
//  OpenTweet
//
//  Created by Josh Roberts on 25/10/2022.
//

import SwiftUI

struct TweetInfoView: View {
    
    let commentsCount: Int
    
    var body: some View {
        HStack(spacing: 4) {
            Image(systemName: "bubble.right")
            Text("\(commentsCount)")
            Spacer()
        }
        .foregroundColor(commentsCount > 0 ? .cyan : .gray)
        .font(.callout)
    }
}

struct TweetInfoView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            TweetInfoView(commentsCount: 0)
            TweetInfoView(commentsCount: 5)
        }
    }
}
