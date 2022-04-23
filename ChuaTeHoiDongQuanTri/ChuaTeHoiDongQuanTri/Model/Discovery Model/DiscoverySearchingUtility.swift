//
//  DiscoverySearchingUtility.swift
//  ChuTeHoiDongQuanTri
//
//  Created by admin on 19/04/2022.
//

import Foundation

class DiscoverySearchingModel {
    var area: String
    var cate: String
    var year: String
    var sub: String
    var order: String
    
    init(area: String, cate: String, year: String, sub: String, order: String) {
        self.area = area
        self.cate = cate
        self.year = year
        self.sub = sub
        self.order = order
    }
}

class DiscoverySearchingUtility {
    static let share = DiscoverySearchingUtility()
    var discoverySearchingModel = DiscoverySearchingModel(area: "", cate: "", year: "", sub: "", order: "")
}
