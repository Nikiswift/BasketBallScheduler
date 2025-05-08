//
//  MatchViewModelProtocol.swift
//  BasketBallSchedule
//
//  Created by Nikhil1 Desai on 08/05/25.
//

import Foundation
import Combine

protocol ScheduleModelProtocol {
    func loadData()
    func filterAndGroup()
    func teamLogo(for teamID: String?) -> String?
    func teamColor(for teamID: String?) -> String?
}
