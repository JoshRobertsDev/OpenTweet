//
//  TweetView.swift
//  OpenTweet
//
//  Created by Josh Roberts on 25/10/2022.
//

import SwiftUI

struct TweetView: View {
    
    let tweet: TweetViewModel
    let isRepliedToVisible: Bool
    
    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            AvatarView(url: tweet.avatar)
            
            VStack(alignment: .leading, spacing: 4) {
                TweetAuthorView(author: tweet.author, datePosted: tweet.datePosted)
                
                if isRepliedToVisible, let replyingTo = tweet.replyingTo {
                    HStack(spacing: 4) {
                        Image(systemName: "arrowshape.turn.up.left.fill")
                        Text("in reply to ") + Text(replyingTo).bold()
                    }
                    .font(.callout)
                    .foregroundColor(.cyan)
                }
                
                TweetContentView(content: tweet.content)
                
                TweetInfoView(repliesCount: tweet.repliesCount)
                    .padding(.top, 8)
            }
        }
    }
}

struct TweetView_Previews: PreviewProvider {
    static var previews: some View {
        TweetView(
            tweet: TweetViewModel(
                tweet: MockData.timeline[0],
                allTweets: MockData.timeline,
                tweetService: TweetService()
            ),
            isRepliedToVisible: true
        )
    }
}
