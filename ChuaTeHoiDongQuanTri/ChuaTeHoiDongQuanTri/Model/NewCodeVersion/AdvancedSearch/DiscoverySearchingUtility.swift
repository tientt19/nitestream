//
//  DiscoverySearchingUtility.swift
//  ChuTeHoiDongQuanTri
//
//  Created by admin on 19/04/2022.
//

import Foundation

class DiscoverySearchingModel {
    var params: String
    var area: String
    var category: String
    var year: String
    var subtitles: String
    var order: String
    
    init( params: String,
          area: String,
          cate: String,
          year: String,
          sub: String,
          order: String) {
        self.params = params
        self.area = area
        self.category = cate
        self.year = year
        self.subtitles = sub
        self.order = order
    }
    
    func toDictionary(type: String) -> [String: Any] {
        var json = [String: Any]()
        json["size"] = 180
        json["sort"] = "1654840857389,20372"
        json["params"] = type
        json["area"] = self.area
        json["category"] = self.category
        json["year"] = self.year
        json["subtitles"] = self.subtitles
        json["order"] = "up"
        return json
    }
}

class DiscoverySearchingUtility {
    static let share = DiscoverySearchingUtility()
    
    var discoverySearchingModel = DiscoverySearchingModel(params: "", area: "", cate: "", year: "", sub: "", order: "")
}
