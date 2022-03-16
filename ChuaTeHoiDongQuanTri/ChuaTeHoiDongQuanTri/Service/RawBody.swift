//
//  RawBody.swift
//  ChuaTeHoiDongQuanTri
//
//  Created by Valerian on 16/03/2022.
//

import Foundation

struct RawBody: Codable {

    let category: Int
    let contentId: String
    let episodeId: Int
    let definition: String

    private enum CodingKeys: String, CodingKey {
        case category = "category"
        case contentId = "contentId"
        case episodeId = "episodeId"
        case definition = "definition"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        category = try values.decode(Int.self, forKey: .category)
        contentId = try values.decode(String.self, forKey: .contentId)
        episodeId = try values.decode(Int.self, forKey: .episodeId)
        definition = try values.decode(String.self, forKey: .definition)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(category, forKey: .category)
        try container.encode(contentId, forKey: .contentId)
        try container.encode(episodeId, forKey: .episodeId)
        try container.encode(definition, forKey: .definition)
    }

}
