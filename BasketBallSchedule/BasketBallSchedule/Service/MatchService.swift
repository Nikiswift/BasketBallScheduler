//
//  MatchService.swift
//  BasketBallSchedule
//
//  Created by Nikhil1 Desai on 08/05/25.
//

import Foundation
import Combine

class MatchService: MatchServiceProtocol {
    func fetchMatches() -> AnyPublisher<[Schedules], Error> {
        JSONLoader.loadJSON(filename: "Schedule", type: ScheduleBaseData.self)
            .map { $0.data?.schedules ?? [] }
            .delay(for: .seconds(1), scheduler: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
