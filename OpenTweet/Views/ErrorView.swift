//
//  ErrorView.swift
//  OpenTweet
//
//  Created by Josh Roberts on 25/10/2022.
//

import SwiftUI

struct ErrorView: View {
    
    let errorMessage: ErrorMessage
    
    var body: some View {
        VStack(spacing: 16) {
            Text(errorMessage.title)
                .font(.title)
            
            Text(errorMessage.message)
                .font(.headline)
        }
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(errorMessage: ErrorMessage(title: "Something went wrong", message: "Try again later"))
    }
}
