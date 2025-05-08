

import Foundation
struct TeamsBaseData : Codable {
    let data : TeamsData?

	enum CodingKeys: String, CodingKey {

		case data = "data"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		data = try values.decodeIfPresent(TeamsData.self, forKey: .data)
	}

}
