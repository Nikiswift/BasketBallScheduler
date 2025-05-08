

import Foundation

struct Teams: Codable, Identifiable {
    let id: String
    let name: String
    let shortCode: String
    let city: String
    let division: String
    let conference: String
    let state: String
    let logoURL: String
    let group: String
    let color: String

    enum CodingKeys: String, CodingKey {
        case id = "tid"
        case name = "tn"
        case shortCode = "ta"
        case city = "tc"
        case division = "di"
        case conference = "co"
        case state = "sta"
        case logoURL = "logo"
        case group = "ist_group"
        case color = "color"
    }
}
