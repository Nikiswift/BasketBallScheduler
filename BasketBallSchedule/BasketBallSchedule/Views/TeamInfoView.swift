//
//  TeamInfoView.swift
//  BasketBallSchedule
//
//  Created by Nikhil1 Desai on 08/05/25.
//

import SwiftUI

struct TeamInfoView: View {
    let imageName: String?
    let teamName: String?
    let location: String?

    var body: some View {
        VStack(alignment: .center, spacing: 4) {
            if let icon = imageName {
                CustomAsyncImage(urlString: icon, size: 50)
                    .modifier(IconModifier())
            }
            
            Text(teamName ?? "")
                .modifier(TeamNameModifier())

            Text(location ?? "")
                .modifier(LocationModifier())
        }
        .padding(.horizontal)
    }
}

struct IconModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(width: 50, height: 50)
            .scaledToFit()
    }
}

struct TeamNameModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.headline)
            .foregroundColor(.white)
            .lineLimit(1)
            .truncationMode(.tail)
    }
}

struct LocationModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.subheadline)
            .foregroundColor(.gray)
            .lineLimit(1)
            .truncationMode(.tail)
    }
}
