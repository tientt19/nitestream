//
//  BaseModel.swift
//  ChuTeHoiDongQuanTri
//
//  Created by Valerian on 30/05/2022.
//

import Foundation

class BaseModel<T: Codable>: Codable {
    var code: String?
    var data: T?
    var msg: String?
    
    enum CodingKeys: String, CodingKey {
        case code
        case data
        case msg
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.code = try? container.decodeIfPresent(String.self, forKey: CodingKeys.code)
        self.data = try? container.decodeIfPresent(T.self, forKey: CodingKeys.data)
        self.msg = try? container.decodeIfPresent(String.self, forKey: CodingKeys.msg)
    }
}
