//
//  InvisibleNavigationLink.swift
//  OpenTweet
//
//  Created by Josh Roberts on 25/10/2022.
//

import SwiftUI

struct InvisibleNavigationLink<Label, Destination>: View where Label: View, Destination: View {
    
    private let destination: Destination
    private let label: Label
    
    init(destination: Destination, @ViewBuilder label: () -> Label) {
        self.destination = destination
        self.label = label()
    }
    
    var body: some View {
        ZStack {
            label
            
            NavigationLink(destination: destination) {
                EmptyView()
            }
            .buttonStyle(PlainButtonStyle())
            .frame(width: 0)
            .opacity(0)
        }
    }
}
