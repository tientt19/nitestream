//
//  HomeAlbumsDetailModels.swift
//  ChuTeHoiDongQuanTri
//
//  Created by Valerian on 05/06/2022.
//

import Foundation
import IGListKit

class HomeAlbumsDetailModels: Codable, ListDiffable{
    private var identifier: String = UUID().uuidString
    var content: [ContentModels]?
    var headImg: String?
    var id: Int?
    var isFavorites: Bool?
    var name: String?
    var shareImg: String?
    var style: Int?
    var subheading: String?
    var totalElements: Int?
    
    enum CodingKeys: String, CodingKey {
        case content
        case headImg
        case id
        case isFavorites
        case name
        case shareImg
        case style
        case subheading
        case totalElements
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.content = try? container.decodeIfPresent([ContentModels].self, forKey: .content)
        self.headImg = try? container.decodeIfPresent(String.self, forKey: CodingKeys.headImg)
        self.id = try? container.decodeIfPresent(Int.self, forKey: .id)
        self.isFavorites = try? container.decodeIfPresent(Bool.self, forKey: .isFavorites)
        self.name = try? container.decodeIfPresent(String.self, forKey: .name)
        self.shareImg = try? container.decodeIfPresent(String.self, forKey: .shareImg)
        self.style = try? container.decodeIfPresent(Int.self, forKey: .style)
        self.subheading = try? container.decodeIfPresent(String.self, forKey: .subheading)
        self.totalElements = try? container.decodeIfPresent(Int.self, forKey: .totalElements)
    }
    
    func diffIdentifier() -> NSObjectProtocol {
        return identifier as NSString
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let object = object as? HomeAlbumsDetailModels else {
            return false
        }
        
        return self.identifier == object.identifier
    }
}


class ContentModels: Codable {
    var contentId: String?
    var domainType: Int?
    var dramaType: String?
    var image: String?
    var introduction, name: String?
    var releaseTime: Int?
    var score: Double?
    
    enum CodingKeys: String, CodingKey {
        case contentId
        case domainType, dramaType, image, introduction, name, releaseTime, score
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.contentId = try? container.decodeIfPresent(String.self, forKey: .contentId)
        self.domainType = try? container.decodeIfPresent(Int.self, forKey: .domainType)
        self.dramaType = try? container.decodeIfPresent(String.self, forKey: .dramaType)
        self.image = try? container.decodeIfPresent(String.self, forKey: .image)
        self.introduction = try? container.decodeIfPresent(String.self, forKey: .introduction)
        self.name = try? container.decodeIfPresent(String.self, forKey: .name)
        self.releaseTime = try? container.decodeIfPresent(Int.self, forKey: .releaseTime)
        self.score = try? container.decodeIfPresent(Double.self, forKey: .score)
    }
}
