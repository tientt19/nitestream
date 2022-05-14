//
//  Section.swift
//  ChuaTeHoiDongQuanTri
//
//  Created by Valerian on 15/03/2022.
//

import Foundation
import IGListKit

enum FooterDetailSectionTypes: String {
    case eps = "Episodes"
    case refList = "In this series"
    case likeList = "Similar to this"
}

class Section: Hashable, ListDiffable {
    var identifier = UUID().uuidString

    var title: String
    var data: [DataModel]
    
    init(data: [DataModel], title: String) {
        self.data = data
        self.title = title
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
    
    static func == (lhs: Section, rhs: Section) -> Bool {
        lhs.identifier == rhs.identifier
    }
    
    func diffIdentifier() -> NSObjectProtocol {
        return identifier as NSString
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let object = object as? Section else {
            return false
        }
        
        return self.identifier == object.identifier
    }
}

class ListCollection: ListDiffable {
    
    private var identifier = UUID().uuidString
    var section: [Section]
    
    init(section: [Section]) {
        self.section = section
    }
    
    func diffIdentifier() -> NSObjectProtocol {
        return identifier as NSString
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let object = object as? ListCollection else {
            return false
        }
        
        return self.identifier == object.identifier
    }
}

class EpisodeCollection: ListDiffable {
    
    private var identifier = UUID().uuidString
    var listEpisode: [EpisodeVo]
    
    init(listEpisode: [EpisodeVo]) {
        self.listEpisode = listEpisode
    }
    
    func diffIdentifier() -> NSObjectProtocol {
        return identifier as NSString
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let object = object as? EpisodeCollection else {
            return false
        }
        
        return self.identifier == object.identifier
    }
}
