//
//  TweetDetailView.swift
//  OpenTweet
//
//  Created by Josh Roberts on 25/10/2022.
//

import SwiftUI

struct TweetDetailView: View {
    
    @ObservedObject var tweet: TweetViewModel
    
    init(tweet: TweetViewModel) {
        self.tweet = tweet
        tweet.fetchTweetReplies()
    }
    
    var body: some View {
        List {
            Section {
                VStack(alignment: .leading, spacing: 8) {
                    HStack(spacing: 16) {
                        AvatarView(url: tweet.avatar)
                        TweetAuthorView(author: tweet.author, datePosted: tweet.datePosted)
                    }
                    
                    TweetContentView(content: tweet.content)
                        .font(.title)
                    
                    TweetInfoView(repliesCount: tweet.repliesCount)
                        .padding(.top, 8)
                }
            }
            
            Section {
                switch tweet.replies {
                case .notInitiated: EmptyView()
                case .fetching: FetchingView()
                case .fetched(let replies):
                    ForEach(replies) { tweetReply in
                        InvisibleNavigationLink(destination: TweetDetailView(tweet: tweetReply)) {
                            TweetView(tweet: tweetReply, isRepliedToVisible: false)
                        }
                    }
                case .failed(let errorMessage):
                    ErrorView(errorMessage: errorMessage)
                }
            }
        }
        .listStyle(PlainListStyle())
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct TweetDetailView_Previews: PreviewProvider {
    static var previews: some View {
        TweetDetailView(tweet: TweetViewModel(
            tweet: MockData.timeline[0],
            allTweets: MockData.timeline,
            tweetService: TweetService()
        ))
        
        TweetDetailView(tweet: TweetViewModel(
            tweet: MockData.timeline[1],
            allTweets: MockData.timeline,
            tweetService: TweetService()
        ))
    }
}
