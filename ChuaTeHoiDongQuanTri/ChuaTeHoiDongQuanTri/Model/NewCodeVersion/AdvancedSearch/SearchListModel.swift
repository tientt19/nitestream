//
//  SearchListModel.swift
//  ChuTeHoiDongQuanTri
//
//  Created by Valerian on 11/06/2022.
//

import Foundation
import IGListKit

// MARK: - SearchListModel
class SearchListModel: Codable, ListDiffable {
    var id: Int?
    var name, params: String?
    var screeningItems: [ScreeningItem]?
    private var identifier: String = UUID().uuidString
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case params
        case screeningItems
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try? container.decodeIfPresent(Int.self, forKey: .id)
        self.name = try? container.decodeIfPresent(String.self, forKey: .name)
        self.params = try? container.decodeIfPresent(String.self, forKey: .params)
        self.screeningItems = try? container.decodeIfPresent([ScreeningItem].self, forKey: .screeningItems)
    }
    
    func diffIdentifier() -> NSObjectProtocol {
        return identifier as NSString
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let object = object as? SearchListModel else {
            return false
        }
        
        return self.identifier == object.identifier
    }
}

// MARK: - ScreeningItem
class ScreeningItem: Codable, ListDiffable {
    var id: Int?
    var items: [Item]?
    var name: String?
    private var identifier: String = UUID().uuidString

    enum CodingKeys: String, CodingKey {
        case id
        case items
        case name
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try? container.decodeIfPresent(Int.self, forKey: .id)
        self.name = try? container.decodeIfPresent(String.self, forKey: .name)
        self.items = try? container.decodeIfPresent([Item].self, forKey: .items)
    }
    
    func diffIdentifier() -> NSObjectProtocol {
        return identifier as NSString
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let object = object as? ScreeningItem else {
            return false
        }
        
        return self.identifier == object.identifier
    }
}

// MARK: - Item
class Item: Codable {
    var name, params: String?
    var screeningType: String?
    var isSelected: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case name
        case params
        case screeningType
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.name = try? container.decodeIfPresent(String.self, forKey: .name)
        self.params = try? container.decodeIfPresent(String.self, forKey: .params)
        self.screeningType = try? container.decodeIfPresent(String.self, forKey: .screeningType)
    }
}
