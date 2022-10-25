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
                    InvisibleNavigationLink(destination: TweetDetailView(tweet: tweet)) {
                        TweetView(tweet: tweet)
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
