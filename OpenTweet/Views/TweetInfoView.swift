//
//  TweetInfoView.swift
//  OpenTweet
//
//  Created by Josh Roberts on 25/10/2022.
//

import SwiftUI

struct TweetInfoView: View {
    
    let repliesCount: Int
    
    var body: some View {
        HStack(spacing: 4) {
            Image(systemName: "bubble.right")
            Text("\(repliesCount)")
            Spacer()
        }
        .foregroundColor(repliesCount > 0 ? .cyan : .gray)
        .font(.callout)
    }
}

struct TweetInfoView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            TweetInfoView(repliesCount: 0)
            TweetInfoView(repliesCount: 5)
        }
    }
}
