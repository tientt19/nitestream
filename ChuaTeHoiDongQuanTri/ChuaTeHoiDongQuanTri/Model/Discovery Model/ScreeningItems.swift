//
//  ScreeningItems.swift
//  ChuTeHoiDongQuanTri
//
//  Created by admin on 08/04/2022.
//

import Foundation

class ScreeningItems {

    var id: Int?
    var items: [DiscoveryItem]?
    var name: String?

    init(_ dict: [String: Any]) {
        id = dict["id"] as? Int

        if let itemsDictArray = dict["items"] as? [[String: Any]] {
            items = itemsDictArray.map { DiscoveryItem($0) }
        }
        name = dict["name"] as? String
    }

    func toDictionary() -> [String: Any] {
        var jsonDict = [String: Any]()
        jsonDict["id"] = id
        jsonDict["items"] = items?.map { $0.toDictionary() }
        jsonDict["name"] = name
        return jsonDict
    }

}
