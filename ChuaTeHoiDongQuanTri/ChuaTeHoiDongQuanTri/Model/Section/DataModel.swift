//
//  DataModel.swift
//  ChuaTeHoiDongQuanTri
//
//  Created by Valerian on 15/03/2022.
//

import Foundation

class DataModel : Hashable {
    var id : String!
    var name : String!
    var category : Int!
    var coverHorizontalUrl : String!
    
    init(id : String, category : Int, name : String, coverHorizontalUrl : String){
        self.category = category
        self.coverHorizontalUrl = coverHorizontalUrl
        self.id = id
        self.name = name
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: DataModel, rhs: DataModel) -> Bool {
        lhs.id == rhs.id
    }
}
