//
//  HomeBannerModels.swift
//  ChuTeHoiDongQuanTri
//
//  Created by Valerian on 04/06/2022.
//

import Foundation
import IGListKit

class HomeBannerModels: Codable {
    var id: Int?
    var imgUrl: String?
    var isNeedLogin: Bool?
    var jumpParam, jumpType, title: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case imgUrl
        case isNeedLogin, jumpParam, jumpType, title
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try? container.decodeIfPresent(Int.self, forKey: .id)
        self.imgUrl = try? container.decodeIfPresent(String.self, forKey: CodingKeys.imgUrl)
        self.isNeedLogin = try? container.decodeIfPresent(Bool.self, forKey: .isNeedLogin)
        self.jumpParam = try? container.decodeIfPresent(String.self, forKey: .jumpParam)
        self.jumpType = try? container.decodeIfPresent(String.self, forKey: .jumpType)
        self.title = try? container.decodeIfPresent(String.self, forKey: .title)
    }
}
