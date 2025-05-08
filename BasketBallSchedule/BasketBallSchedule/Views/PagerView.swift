//
//  PagerView.swift
//  BasketBallSchedule
//
//  Created by Nikhil1 Desai on 08/05/25.
//

import SwiftUI

struct LiveMatchesPagerView: View {
    var liveHomeMatches: [Schedules] = []

    var body: some View {
        if !liveHomeMatches.isEmpty {
            VStack(alignment: .leading) {
                Text("Home Live Matches")
                    .modifier(LiveMatchesTitleModifier())

                TabView {
                    ForEach(liveHomeMatches, id: \.id) { match in
                        MatchScoreView(schedule: match)
                    }
                }
                .modifier(TabViewModifier())
            }
            .padding(.top)
        }
    }
}

// MARK: - Modifiers

struct LiveMatchesTitleModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.title3)
            .foregroundStyle(.baseWhite)
            .bold()
            .padding(.horizontal)
    }
}

struct TabViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .tabViewStyle(.page(indexDisplayMode: .automatic))
            .frame(height: 200)
    }
}
