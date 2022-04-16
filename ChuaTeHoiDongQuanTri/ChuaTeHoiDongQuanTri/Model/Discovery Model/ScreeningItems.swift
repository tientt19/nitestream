//
//  ScreeningItems.swift
//  ChuTeHoiDongQuanTri
//
//  Created by admin on 08/04/2022.
//

import Foundation
enum DiscoveryType {
    case area
    case type
    case year
    case sub
    case newOrHot
}

class ScreeningItems {

    var id: Int?
    var items: [DiscoveryItem]?
    var name: String?
    var discoveryType : DiscoveryType

    init(_ dict: [String: Any]) {
        id = dict["id"] as? Int

        if let itemsDictArray = dict["items"] as? [[String: Any]] {
            items = itemsDictArray.map { DiscoveryItem($0) }
        }
        name = dict["name"] as? String
        items!.first?.isSelected = true
        switch  id {
        case 4:
            discoveryType = .area
        case 5:
            discoveryType = .type
        case 6:
            discoveryType = .year
        default:
            if name == "字幕筛选" {
                discoveryType = .sub
            } else {
                discoveryType = .newOrHot
            }
        }
    }

    func toDictionary() -> [String: Any] {
        var jsonDict = [String: Any]()
        jsonDict["id"] = id
        jsonDict["items"] = items?.map { $0.toDictionary() }
        jsonDict["name"] = name
        return jsonDict
    }
    
    init(id: Int, item: [DiscoveryItem], name: String, disc: DiscoveryType) {
        self.id = id
        self.items = []
        self.name = name
        self.discoveryType = disc
    }
}
