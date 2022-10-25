//
//  AvatarView.swift
//  OpenTweet
//
//  Created by Josh Roberts on 25/10/2022.
//

import SwiftUI

struct AvatarView: View {
    
    let url: URL?
    
    var body: some View {
        AsyncImage(
            url: url,
            content: { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            },
            placeholder: {
                Image(systemName: "person.fill")
                    .font(.headline)
                    .foregroundColor(.gray)
                    .overlay(
                        Circle()
                            .stroke(Color.gray, lineWidth: 0.5)
                            .frame(width: 40, height: 40)
                    )
            }
        )
        .frame(width: 40, height: 40)
        .clipShape(Circle())
    }
}

struct AvatarView_Previews: PreviewProvider {
    static var previews: some View {
        AvatarView(url: nil)
    }
}
