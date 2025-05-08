//
//  TeamServiceProtocol.swift
//  BasketBallSchedule
//
//  Created by Nikhil1 Desai on 08/05/25.
//

import Foundation
import Combine

protocol TeamServiceProtocol {
    func fetchTeams() -> AnyPublisher<[Teams], Error>
}
