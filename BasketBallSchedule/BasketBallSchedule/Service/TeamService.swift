//
//  TeamService.swift
//  BasketBallSchedule
//
//  Created by Nikhil1 Desai on 08/05/25.
//

import Foundation
import Combine
 
class TeamService: TeamServiceProtocol {
    func fetchTeams() -> AnyPublisher<[Teams], Error> {
        JSONLoader.loadJSON(filename: "teams", type: TeamsBaseData.self)
            .map { $0.data?.teams ?? [] }
            .eraseToAnyPublisher()
    }
}
