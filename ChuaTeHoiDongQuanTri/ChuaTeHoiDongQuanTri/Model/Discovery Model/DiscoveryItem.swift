//
//  DiscoveryItem.swift
//  ChuTeHoiDongQuanTri
//
//  Created by admin on 08/04/2022.
//

import Foundation

class DiscoveryItem {
    var name: String?
    var params: String?
    var screeningType: String?
    
    init(_ dict: [String: Any]) {
        name = dict["name"] as? String
        params = dict["params"] as? String
        screeningType = dict["screeningType"] as? String
    }
    
    func toDictionary() -> [String: Any] {
        var jsonDict = [String: Any]()
        jsonDict["name"] = name
        jsonDict["params"] = params
        jsonDict["screeningType"] = screeningType
        return jsonDict
    }
}
