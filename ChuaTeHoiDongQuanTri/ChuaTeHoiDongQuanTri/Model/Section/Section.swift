//
//  Section.swift
//  ChuaTeHoiDongQuanTri
//
//  Created by Valerian on 15/03/2022.
//

import Foundation

class Section : Hashable {
    var id = UUID()
    
    var title: String
    var data: [DataModel]
    
    init(data: [DataModel], title: String) {
        self.data = data
        self.title = title
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Section, rhs: Section) -> Bool {
        lhs.id == rhs.id
    }
}
