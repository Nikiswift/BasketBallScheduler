//
//  MatchScoreView.swift
//  BasketBallSchedule
//
//  Created by Nikhil1 Desai on 08/05/25.
//

import SwiftUI

struct MatchScoreView: View {
    var schedule: Schedules
    var body: some View {
        VStack {
            Text(schedule.arenaName ?? "")
                .modifier(ArenaNameModifier())

            RoundedRectangle(cornerRadius: 12)
                .foregroundStyle(.baseWhite)
                .frame(height: 20)
                .frame(width: 80)
                .overlay {
                    Text(schedule.arenaCity ?? "")
                        .modifier(ArenaCityModifier())
                }

            HStack {
                TeamInfoView(imageName: schedule.visitorTeam?.teamIcon, teamName: schedule.visitorTeam?.teamName, location: schedule.visitorTeam?.teamCountry)

                ScoreView(score: "\(schedule.visitorTeam?.score ?? "") : \(schedule.homeTeam?.score ?? "")")

                TeamInfoView(imageName: schedule.homeTeam?.teamIcon, teamName: schedule.homeTeam?.teamName, location: schedule.visitorTeam?.teamCountry)
            }
            .padding(.horizontal)
            .padding(.bottom)
        }
        .padding(.top, 24)
        .frame(maxWidth: .infinity)
        .background(.baseBlack)
    }
}

// MARK: - Modifiers

struct ArenaNameModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.title2)
            .foregroundColor(.baseWhite)
    }
}

struct ArenaCityModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.subheadline)
            .foregroundColor(.red)
    }
}
