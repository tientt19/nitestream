//
//  DataModel.swift
//  ChuaTeHoiDongQuanTri
//
//  Created by Valerian on 15/03/2022.
//

import Foundation
import IGListKit

class DataModel: Hashable, ListDiffable {
    var identifier = UUID().uuidString
    var name : String!
    var category : Int!
    var coverHorizontalUrl : String!
    
    init(identifier : String, category : Int, name : String, coverHorizontalUrl : String){
        self.category = category
        self.coverHorizontalUrl = coverHorizontalUrl
        self.identifier = identifier
        self.name = name
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
    
    static func == (lhs: DataModel, rhs: DataModel) -> Bool {
        lhs.identifier == rhs.identifier
    }
    
    func diffIdentifier() -> NSObjectProtocol {
        return identifier as NSString
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let object = object as? DataModel else {
            return false
        }
        
        return self.identifier == object.identifier
    }
}
