//
//  BasketBallScheduleApp.swift
//  BasketBallSchedule
//
//  Created by Nikhil1 Desai on 05/05/25.
//

import SwiftUI

@main
struct BasketBallScheduleApp: App {
    var body: some Scene {
        WindowGroup {
            ScheduleGamesTabView(viewModel: ScheduleViewModel(matchService: MatchService(), teamService: TeamService()))
        }
    }
}
