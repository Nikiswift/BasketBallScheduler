//
//  ScheduleViewModel.swift
//  BasketBallSchedule
//
//  Created by Nikhil1 Desai on 08/05/25.
//

import Foundation
import Combine

class ScheduleViewModel: ScheduleModelProtocol, ObservableObject {
    
    @Published var sections: [MatchSection] = []
    @Published var searchText = ""
    var months: [String] = []
    private var allMatches: [Schedules] = []
    private var teams: [String: Teams] = [:]
    private var cancellables = Set<AnyCancellable>()
    private let matchService: MatchServiceProtocol
    private let teamService: TeamServiceProtocol

    init(matchService: MatchServiceProtocol, teamService: TeamServiceProtocol) {
        self.matchService = matchService
        self.teamService = teamService
        self.handleSearch()
    }
    func handleSearch() {
        $searchText
            .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { [weak self] _ in
                self?.filterAndGroup()
            }
            .store(in: &cancellables)
    }


    fileprivate func filterScheduledData(_ matches: [Schedules]) {
        self.allMatches = matches.map { [weak self] match  in
            var updatedMatch = match
            if var home = match.homeTeam {
                home.teamIcon = self?.teamLogo(for: home.teamID)
                home.teamColor = self?.teamColor(for: home.teamID)
                updatedMatch.homeTeam = home
            }
            if var visitor = match.visitorTeam {
                visitor.teamIcon = self?.teamLogo(for: visitor.teamID)
                visitor.teamColor = self?.teamColor(for: visitor.teamID)
                updatedMatch.visitorTeam = visitor
            }
            return updatedMatch
        }.sorted {
            let formatter = ISO8601DateFormatter()
            let date0 = formatter.date(from: $0.gametime ?? "") ?? Date.distantFuture
            let date1 = formatter.date(from: $1.gametime ?? "") ?? Date.distantFuture
            return date0 < date1
        }
    }
    
    func loadData() {
        teamService.fetchTeams()
            .combineLatest(matchService.fetchMatches())
            .sink(receiveCompletion: { _ in }, receiveValue: { [weak self] teams, matches in
                self?.teams = Dictionary(uniqueKeysWithValues: teams.map { ($0.id, $0) })
                self?.filterScheduledData(matches)
                self?.filterAndGroup()
            })
            .store(in: &cancellables)
    }

    func filterAndGroup() {
        let filteredMatches = filterMatches()

        let groupedMatches = groupMatches(filteredMatches)

        self.sections = groupedMatches.keys.sorted().map { key in
            MatchSection(title: key, matches: groupedMatches[key] ?? [])
        }

        self.months = self.sections.map { $0.title }
    }

    private func filterMatches() -> [Schedules] {
        return searchText.isEmpty ? allMatches : allMatches.filter { match in
            matchMatchesSearchCriteria(match)
        }
    }

    private func matchMatchesSearchCriteria(_ match: Schedules) -> Bool {
        let matchCriteria: [String?] = [
            match.arenaName,
            match.arenaCity,
            match.homeTeam?.teamName,
            match.visitorTeam?.teamName
        ]
        
        return matchCriteria.contains { criterion in
            (criterion ?? "").localizedCaseInsensitiveContains(searchText)
        }
    }

    private func groupMatches(_ matches: [Schedules]) -> [String: [Schedules]] {
        let inputFormatter = createInputDateFormatter()
        let outputFormatter = createOutputDateFormatter()

        return Dictionary(grouping: matches) { match -> String in
            groupByDate(match, inputFormatter: inputFormatter, outputFormatter: outputFormatter)
        }
    }

    private func createInputDateFormatter() -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        return formatter
    }

    private func createOutputDateFormatter() -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone.current // Display in user local time
        return formatter
    }

    private func groupByDate(_ match: Schedules, inputFormatter: DateFormatter, outputFormatter: DateFormatter) -> String {
        if let date = inputFormatter.date(from: match.gametime ?? "") {
            return outputFormatter.string(from: date)
        } else {
            return "Unknown"
        }
    }


    func teamLogo(for teamID: String?) -> String? {
        guard let id = teamID else { return nil }
        return teams[id]?.logoURL
    }
    
    func teamColor(for teamID: String?) -> String? {
        guard let id = teamID else { return nil }
        return teams[id]?.color
    }
    
}
