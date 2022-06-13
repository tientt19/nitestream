//
//  SearchResultModel.swift
//  nitestream
//
//  Created by Valerian on 13/06/2022.
//

import Foundation
import IGListKit

// MARK: - SearchResultModel
class SearchResultModel: Codable, ListDiffable {
    var searchResults: [SearchResults]?
    
    private var identifier: String = UUID().uuidString
    
    enum CodingKeys: String, CodingKey {
        case searchResults
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.searchResults = try? container.decodeIfPresent([SearchResults].self, forKey: .searchResults)
    }
    
    
    func diffIdentifier() -> NSObjectProtocol {
        return identifier as NSString
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let object = object as? SearchResultModel else {
            return false
        }
        
        return self.identifier == object.identifier
    }
}

// MARK: - SearchResultContentModel
class SearchResults: Codable{
    var coverVerticalURL: String?
    var domainType: Int?
    var id, name, score, sort: String?
    
    enum CodingKeys: String, CodingKey {
        case coverVerticalURL
        case domainType, id, name, score, sort
    }
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.coverVerticalURL = try? container.decodeIfPresent(String.self, forKey: .coverVerticalURL)
        self.domainType = try? container.decodeIfPresent(Int.self, forKey: .domainType)
        self.id = try? container.decodeIfPresent(String.self, forKey: .id)
        self.name = try? container.decodeIfPresent(String.self, forKey: .name)
        self.score = try? container.decodeIfPresent(String.self, forKey: .score)
        self.sort = try? container.decodeIfPresent(String.self, forKey: .sort)
    }
}
