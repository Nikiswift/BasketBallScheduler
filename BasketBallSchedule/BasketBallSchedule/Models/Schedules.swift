
import Foundation

struct Schedules : Codable, Identifiable {
	let id : String?
	let year : Int?
	let league_id : String?
	let season_id : String?
	var homeTeam : Team?
	var visitorTeam : Team?
    let statusTimeText: String
	let gameStatus : Int?
    let gametime : String?
    let arenaName : String?
    let arenaCity : String?
    let arenaState : String?

	enum CodingKeys: String, CodingKey {

		case id = "uid"
		case year = "year"
		case league_id = "league_id"
		case season_id = "season_id"
		case homeTeam = "h"
		case visitorTeam = "v"
		case gameStatus = "st"
        case statusTimeText = "stt"
        case gametime = "gametime"
        case arenaName = "arena_name"
        case arenaCity = "arena_city"
        case arenaState = "arena_state"
	}

}
