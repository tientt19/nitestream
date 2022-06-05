//
//  DaiNewsModel.swift
//  ChuTeHoiDongQuanTri
//
//  Created by Valerian on 04/06/2022.
//

import Foundation
import IGListKit

class DailyNewsModel: Codable, ListDiffable {
    private var identifier: String = UUID().uuidString

    var list: [NewsModel]?
    var page: Int?
    
    enum CodingsKey: String, CodingKey {
        case list
        case page
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.list = try? container.decodeIfPresent([NewsModel].self, forKey: .list)
        self.page = try? container.decodeIfPresent(Int.self, forKey: .page)
    }
    
    func diffIdentifier() -> NSObjectProtocol {
        return identifier as NSString
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let object = object as? DailyNewsModel else {
            return false
        }
        
        return self.identifier == object.identifier
    }
}

//MARK: - NewsModel
class NewsModel: Codable {
    var coverImg: String?
    var createTime, id: Int?
    var introduction: String?
    var keyword: [String]?
    var title: String?
    
    enum CodingKeys: String, CodingKey {
        case coverImg
        case introduction
        case title
        case keyword
        case createTime, id
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.coverImg = try? container.decodeIfPresent(String.self, forKey: CodingKeys.coverImg)
        self.createTime = try? container.decodeIfPresent(Int.self, forKey: CodingKeys.createTime)
        self.id = try? container.decodeIfPresent(Int.self, forKey: CodingKeys.id)
        self.introduction = try? container.decodeIfPresent(String.self, forKey: CodingKeys.introduction)
        self.keyword = try? container.decodeIfPresent([String].self, forKey: CodingKeys.keyword)
        self.title = try? container.decodeIfPresent(String.self, forKey: CodingKeys.title)
    }
}
