

import Foundation
struct ScheduleData : Codable {
	let schedules : [Schedules]?

	enum CodingKeys: String, CodingKey {

		case schedules = "schedules"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		schedules = try values.decodeIfPresent([Schedules].self, forKey: .schedules)
	}

}
