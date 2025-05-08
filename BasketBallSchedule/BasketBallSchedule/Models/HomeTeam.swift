
import Foundation
struct Team : Codable {
    let teamID: String?
    let result: String?
    let teamAway: String?
    let teamName: String?
    let teamCountry: String?
    let score: String?
    let isGroupStage: String?
    var teamIcon: String?
    var teamColor: String?
    
	enum CodingKeys: String, CodingKey {
        case teamID = "tid"
        case result = "re"
        case teamAway = "ta"
        case teamName = "tn"
        case teamCountry = "tc"
        case score = "s"
        case isGroupStage = "ist_group"
	}

}
