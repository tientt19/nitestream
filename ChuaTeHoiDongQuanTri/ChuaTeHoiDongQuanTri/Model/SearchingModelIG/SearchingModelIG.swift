//
//  SearchingModelIG.swift
//  ChuTeHoiDongQuanTri
//
//  Created by Valerian on 06/05/2022.
//

import Foundation
import IGListKit

class SearchingModelIG: ListDiffable {
    private var identifier: String = UUID().uuidString
    var content : String!
    
    
    func diffIdentifier() -> NSObjectProtocol {
        return identifier as NSString
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let object = object as? SearchingModelIG else {
            return false
        }
        
        return self.identifier == object.identifier
    }
}
