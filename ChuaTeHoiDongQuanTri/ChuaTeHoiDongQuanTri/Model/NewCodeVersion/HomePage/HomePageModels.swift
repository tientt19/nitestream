//
//  HomePageModel.swift
//  ChuTeHoiDongQuanTri
//
//  Created by Valerian on 04/06/2022.
//

import Foundation
import IGListKit

class HomeListBannerModel: ListDiffable {
    private var identifier: String = UUID().uuidString
    var listBanner: [HomeBannerModels]?
    
    init(banners: [HomeBannerModels]) {
        self.listBanner = banners
    }
    
    func diffIdentifier() -> NSObjectProtocol {
        return identifier as NSString
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let object = object as? HomeListBannerModel else {
            return false
        }
        
        return self.identifier == object.identifier
    }
}

class HomePageModels: Codable, ListDiffable {
    private var identifier: String = UUID().uuidString

    var page: Int?
    var recommendItems: [RecommendItemModel]?
    var searchKeyWord: String?
    
    enum CodingKeys: String, CodingKey {
        case page
        case recommendItems
        case searchKeyWord
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.page = try? container.decodeIfPresent(Int.self, forKey: .page)
        self.recommendItems = try? container.decodeIfPresent([RecommendItemModel].self, forKey: .recommendItems)
        self.searchKeyWord = try? container.decodeIfPresent(String.self, forKey: .searchKeyWord)
    }
    
    func diffIdentifier() -> NSObjectProtocol {
        return identifier as NSString
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let object = object as? HomePageModels else {
            return false
        }
        
        return self.identifier == object.identifier
    }
}

//MARK: - RecommendItemModel
class RecommendItemModel: Codable {
    var coverType, homeSectionID: Int?
    var homeSectionName, homeSectionType: String?
    var recommendContentVOList: [RecommendContentVOListModel]?
    var refID: Int?
    var refRedirectURL: String?
    
    enum CodingKeys: String, CodingKey {
        case coverType
        case homeSectionID = "homeSectionId"
        case homeSectionName, homeSectionType, recommendContentVOList
        case refID = "refId"
        case refRedirectURL = "refRedirectUrl"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.coverType = try? container.decodeIfPresent(Int.self, forKey: .coverType)
        self.homeSectionID = try? container.decodeIfPresent(Int.self, forKey: .homeSectionID)
        self.homeSectionName = try? container.decodeIfPresent(String.self, forKey: .homeSectionName)
        self.homeSectionType = try? container.decodeIfPresent(String.self, forKey: .homeSectionType)
        self.recommendContentVOList = try? container.decodeIfPresent([RecommendContentVOListModel].self, forKey: .recommendContentVOList)
        self.refID = try? container.decodeIfPresent(Int.self, forKey: .refID)
        self.refRedirectURL = try? container.decodeIfPresent(String.self, forKey: .refRedirectURL)
    }
}

//MARK: - RecommendContentVOListModel
class RecommendContentVOListModel: Codable {
    var category: Int?
    var contentType: String?
    var id: Int?
    var imageUrl: String?
    var jumpAddress, jumpType: String?
    var needLogin: Bool?
    var resourceNum: Int?
    var resourceStatus: Int?
    var showMark: Bool?
    var title: String?

    enum CodingKeys: String, CodingKey {
        case category, contentType, id
        case imageUrl 
        case jumpAddress, jumpType, needLogin, resourceNum, resourceStatus, showMark, title
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.category = try? container.decodeIfPresent(Int.self, forKey: .category)
        self.contentType = try? container.decodeIfPresent(String.self, forKey: .contentType)
        self.id = try? container.decodeIfPresent(Int.self, forKey: .id)
        self.imageUrl = try? container.decodeIfPresent(String.self, forKey: .imageUrl)
        self.jumpAddress = try? container.decodeIfPresent(String.self, forKey: .jumpAddress)
        self.jumpType = try? container.decodeIfPresent(String.self, forKey: .jumpType)
        self.needLogin = try? container.decodeIfPresent(Bool.self, forKey: .needLogin)
        self.resourceNum = try? container.decodeIfPresent(Int.self, forKey: .resourceNum)
        self.resourceStatus = try? container.decodeIfPresent(Int.self, forKey: .resourceStatus)
        self.showMark = try? container.decodeIfPresent(Bool.self, forKey: .showMark)
        self.title = try? container.decodeIfPresent(String.self, forKey: .title)
    }
}
