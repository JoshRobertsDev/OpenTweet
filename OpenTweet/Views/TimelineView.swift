//
//  TimelineView.swift
//  OpenTweet
//
//  Created by Josh Roberts on 25/10/2022.
//

import SwiftUI

struct TimelineView: View {
    
    @ObservedObject private var timelineViewModel = TimelineViewModel(tweetService: TweetService())
    
    init() {
        timelineViewModel.fetchTimeline()
    }
    
    var body: some View {
        NavigationView {
            List(timelineViewModel.tweets) { tweet in
                Section {
                    HStack(alignment: .top, spacing: 16) {
                        AvatarView(url: tweet.avatar)
                        
                        VStack(alignment: .leading, spacing: 4) {
                            HStack {
                                Text(tweet.author)
                                    .font(.headline)
                                    .fontWeight(.semibold)
                                    .lineLimit(1)
                                
                                Spacer()
                                
                                Text(tweet.datePosted)
                                    .foregroundColor(.secondary)
                                    .font(.caption)
                                    .fontWeight(.semibold)
                                    .lineLimit(1)
                            }
                            
                            Text(tweet.content)
                                .font(.body)
                                .fontWeight(.regular)
                                .textSelection(.enabled)
                            
                            HStack(spacing: 4) {
                                Image(systemName: "bubble.right")
                                Text("\(tweet.replies)")
                                Spacer()
                            }
                            .foregroundColor(tweet.replies > 0 ? .cyan : .gray)
                            .font(.callout)
                            .padding(.top, 8)
                            
                        }
                    }
                    .listRowInsets(.init(top: 20, leading: 20, bottom: 20, trailing: 20))
                }
            }
            .listStyle(PlainListStyle())
            .navigationTitle("Timeline")
            .background(Color(red: 243 / 255, green: 243 / 255, blue: 243 / 255))
        }
    }
}

struct TimelineView_Previews: PreviewProvider {
    static var previews: some View {
        TimelineView()
    }
}
