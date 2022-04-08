//
//  DiscoveryModel.swift
//  ChuTeHoiDongQuanTri
//
//  Created by admin on 08/04/2022.
//

import Foundation

class DiscoveryModel {
    var id: Int?
    var name: String?
    var params: String?
    var screeningItems: [ScreeningItems]?
    
    init(_ dict: [String: Any]) {
        id = dict["id"] as? Int
        name = dict["name"] as? String
        params = dict["params"] as? String
        
        if let screeningItemsDictArray = dict["screeningItems"] as? [[String: Any]] {
            screeningItems = screeningItemsDictArray.map { ScreeningItems($0) }
        }
    }
    
    func toDictionary() -> [String: Any] {
        var jsonDict = [String: Any]()
        jsonDict["id"] = id
        jsonDict["name"] = name
        jsonDict["params"] = params
        jsonDict["screeningItems"] = screeningItems?.map { $0.toDictionary() }
        return jsonDict
    }
}
