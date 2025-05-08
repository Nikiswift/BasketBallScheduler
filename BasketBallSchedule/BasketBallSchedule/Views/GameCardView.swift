//
//  GameCardView.swift
//  BasketBallSchedule
//
//  Created by Nikhil1 Desai on 08/05/25.
//

import SwiftUI

struct GameCardView: View {
    var schedule: Schedules
    var body: some View {
        VStack(spacing: 8) {
            // Header
            TeamHeaderDetailView(data: [schedule.arenaName ?? "", DateUtils.formatDayMonthDate(from: schedule.gametime ?? ""), schedule.statusTimeText])
            // Team View
            HStack(spacing: 8) {
                TeamLogoView(team: schedule.visitorTeam).frame(maxWidth: 100)
                TeamScoreView(schedules: schedule)
                TeamLogoView(team: schedule.homeTeam).frame(maxWidth: 100)
            }.frame(maxWidth: .infinity)
            TeamTicketView(schedules: schedule).frame(height: 30)
        }
        .padding()
        .background((schedule.homeTeam?.teamColor?.isEmpty == nil) ? .baseBlack : Color(hex: schedule.homeTeam?.teamColor ?? ""))
        .cornerRadius(20)
        .padding(.horizontal)
    }
    
}

struct CustomAsyncImage: View {
    let urlString: String?
    let size: CGFloat

    var body: some View {
        if let urlString = urlString,
           let url = URL(string: urlString) {
            AsyncImage(url: url) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .frame(width: size, height: size)
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: size, height: size)
                case .failure:
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: size, height: size)
                        .foregroundColor(.gray)
                @unknown default:
                    EmptyView()
                }
            }
        } else {
            Image(systemName: "photo")
                .resizable()
                .scaledToFit()
                .frame(width: size, height: size)
                .foregroundColor(.gray)
        }
    }
}

struct TeamLogoView: View {
    let team: Team?

    var body: some View {
        VStack(alignment: .center) {
            if let icon = team?.teamIcon {
                CustomAsyncImage(urlString: icon, size: 40)
            }
            if let teamName = team?.teamName {
                Text(teamName)
                    .font(.title2)
                    .bold()
                    .foregroundStyle(.baseWhite)
            }
        }.padding(.vertical, 8)
    }
}

struct TeamHeaderDetailView: View {
    var data: [String] = []
    
    var body: some View {
        HStack {
            ForEach(Array(data.enumerated()), id: \.offset) { detail in
                Text(detail.element).lineLimit(1)
                    .foregroundStyle(.baseWhite)
                if detail.offset < data.count - 1 {
                    Text("|")
                        .foregroundStyle(.baseWhite)
                }
            }
        }
    }
}

struct TeamTicketView: View {
    let schedules: Schedules?
    var body: some View {
        if let status = schedules?.gameStatus, let gameStatus = ScheduleStatus(rawValue: status), gameStatus == .Upcoming  {
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .foregroundStyle(.white)
                .overlay {
                    Text("Buy Tickets")
                }
        }
    }
}

enum ScheduleStatus: Int {
    case Upcoming = 1
    case Live
    case Final
    case Default
}
struct TeamScoreView: View {
    let schedules: Schedules?
    
    var body: some View {
        VStack(alignment: .center, spacing: 16) {
            if let status = schedules?.gameStatus, let gameStatus = ScheduleStatus(rawValue: status), gameStatus == .Live  {
                TeamLiveBadge(team: "Live")
            }
            HStack {
                if let status = schedules?.gameStatus, let gameStatus = ScheduleStatus(rawValue: status), gameStatus != .Upcoming  {
                    Text(schedules?.visitorTeam?.score ?? "")
                        .font(.title2)
                        .bold()
                        .foregroundStyle(.baseWhite)
                    Text("VS")
                        .font(.headline)
                        .bold()
                        .foregroundStyle(.baseWhite.opacity(0.6))
                    Text(schedules?.homeTeam?.score ?? "")
                        .font(.title2)
                        .bold()
                        .foregroundStyle(.baseWhite)
                } else {
                    Text(AppConstants.AppNameID == (schedules?.homeTeam?.teamID) ? "VS" : "@")
                        .font(.headline)
                        .bold()
                        .foregroundStyle(.baseWhite.opacity(0.6))
                }
            }
        }
    }
}

struct TeamLiveBadge: View {
    let team: String
    var body: some View {
        Text(team)
            .padding(.horizontal)
            .padding(.vertical, 2)
            .font(.title2)
            .bold()
            .foregroundStyle(.white)
            .background(.red)
            .cornerRadius(12)
    }
}


struct ScoreView: View {
    let score: String
    var body: some View {
        VStack(alignment: .leading) {
            Text(score)
                .font(.title).fontWeight(.bold)
                .foregroundColor(.white)
        }
        .padding(.horizontal)
    }
}
