

import Foundation

struct MatchSection: Identifiable {
    let id = UUID()
    let title: String
    let matches: [Schedules]
}
