//
//  VideoShortModel.swift
//  ChuTeHoiDongQuanTri
//
//  Created by Valerian on 30/05/2022.
//

import Foundation
import IGListKit

//MARK: - VideoShortModel
class VideoShortModel: ListDiffable {
    private var identifier: String = UUID().uuidString
    var videoShortData: ShortVideoModel?
    var reviewData: ReviewShortVideoModel?
    
    init(_ listVideo: ShortVideoModel, _ listReview: ReviewShortVideoModel) {
        self.videoShortData = listVideo
        self.reviewData = listReview
    }
    
    func diffIdentifier() -> NSObjectProtocol {
        return identifier as NSString
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let object = object as? VideoShortModel else {
            return false
        }
        
        return self.identifier == object.identifier
    }
}

//MARK: - ShortVideoModel
class ShortVideoModel: Codable {
    var businessType: Int?
    var currentDefinition: String?
    var episodeId: String?
    var mediaUrl: String?
    var totalDuration: Int?
    
    enum CodingKeys: String, CodingKey{
        case businessType
        case currentDefinition
        case episodeId
        case mediaUrl
        case totalDuration
    }
    
    required init(fromDictionary dictionary: [String:Any]){
        self.businessType = dictionary["businessType"] as? Int
        self.currentDefinition = dictionary["currentDefinition"] as? String
        self.episodeId = dictionary["episodeId"] as? String
        self.mediaUrl = dictionary["mediaUrl"] as? String
        self.totalDuration = dictionary["totalDuration"] as? Int
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.businessType = try? container.decodeIfPresent(Int.self, forKey: CodingKeys.businessType)
        self.currentDefinition = try? container.decodeIfPresent(String.self, forKey: CodingKeys.currentDefinition)
        self.episodeId = try? container.decodeIfPresent(String.self, forKey: CodingKeys.episodeId)
        self.mediaUrl = try? container.decodeIfPresent(String.self, forKey: CodingKeys.mediaUrl)
        self.totalDuration = try? container.decodeIfPresent(Int.self, forKey: CodingKeys.totalDuration)
    }
}

//MARK: - ReviewShortVideoModel
class ReviewShortVideoModel: Codable {
    var category: Int?
    var coverHorizontalUrl: String?
    var coverVerticalUrl: String?
    var duration: Int?
    var id: String?
    var introduction: String?
    var like: Bool?
    var likeCount: Int?
    var mediaInfo: MediaInfoModel?
    var name: String?
    var refList: [RefListModel]?
    var upInfo: upInfoModel?
    
    enum CodingKeys: String, CodingKey{
        case category
        case coverHorizontalUrl
        case coverVerticalUrl
        case duration
        case id
        case introduction
        case like
        case likeCount
        case mediaInfo
        case name
        case refList
        case upInfo
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.category = try? container.decodeIfPresent(Int.self, forKey: CodingKeys.category)
        self.coverHorizontalUrl = try? container.decodeIfPresent(String.self, forKey: CodingKeys.coverHorizontalUrl)
        self.coverVerticalUrl = try? container.decodeIfPresent(String.self, forKey: CodingKeys.coverVerticalUrl)
        self.duration = try? container.decodeIfPresent(Int.self, forKey: CodingKeys.duration)
        self.id = try? container.decodeIfPresent(String.self, forKey: CodingKeys.id)
        self.introduction = try? container.decodeIfPresent(String.self, forKey: CodingKeys.introduction)
        self.like = try? container.decodeIfPresent(Bool.self, forKey: CodingKeys.like)
        self.likeCount = try? container.decodeIfPresent(Int.self, forKey: CodingKeys.likeCount)
        self.mediaInfo = try? container.decodeIfPresent(MediaInfoModel.self, forKey: CodingKeys.mediaInfo)
        self.name = try? container.decodeIfPresent(String.self, forKey: CodingKeys.name)
        self.refList = try? container.decodeIfPresent([RefListModel].self, forKey: CodingKeys.refList)
        self.upInfo = try? container.decodeIfPresent(upInfoModel.self, forKey: CodingKeys.upInfo)
    }
}

// MARK: - MediaInfoModel
class MediaInfoModel: Codable {
    var definitionList: [DefinitionListModel]?
    var id: Int?
    var resourceType: Int?
    var subtitlingList: [String]?
    
    enum CodingKeys: String, CodingKey {
        case definitionList
        case id
        case resourceType
        case subtitlingList
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.definitionList = try? container.decodeIfPresent([DefinitionListModel].self, forKey: CodingKeys.definitionList)
        self.id = try? container.decodeIfPresent(Int.self, forKey: CodingKeys.id)
        self.resourceType = try? container.decodeIfPresent(Int.self, forKey: CodingKeys.resourceType)
        self.subtitlingList = try? container.decodeIfPresent([String].self, forKey: CodingKeys.subtitlingList)
    }
    
}

// MARK: - RefListModel
class RefListModel: Codable {
    var category: Int?
    var coverHorizontalURL, coverVerticalURL: String?
    var drameTypeVo: DrameTypeVoModel?
    var id, name: String?
    var score: Double?
    var tagList: [TagListModel]?
    var year: Int?
    
    enum CodingKeys: String, CodingKey {
         case category
         case coverHorizontalURL = "coverHorizontalUrl"
         case coverVerticalURL = "coverVerticalUrl"
         case drameTypeVo, id, name, score, tagList, year
     }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.category = try? container.decodeIfPresent(Int.self, forKey: CodingKeys.category)
        self.coverHorizontalURL = try? container.decodeIfPresent(String.self, forKey: CodingKeys.coverHorizontalURL)
        self.coverVerticalURL = try? container.decodeIfPresent(String.self, forKey: CodingKeys.coverVerticalURL)
        self.drameTypeVo = try? container.decodeIfPresent(DrameTypeVoModel.self, forKey: CodingKeys.drameTypeVo)
        self.id = try? container.decodeIfPresent(String.self, forKey: CodingKeys.id)
        self.name = try? container.decodeIfPresent(String.self, forKey: CodingKeys.name)
        self.score = try? container.decodeIfPresent(Double.self, forKey: CodingKeys.score)
        self.name = try? container.decodeIfPresent(String.self, forKey: CodingKeys.name)
        self.tagList = try? container.decodeIfPresent([TagListModel].self, forKey: CodingKeys.tagList)
        self.year = try? container.decodeIfPresent(Int.self, forKey: CodingKeys.year)
    }
}

// MARK: - DrameTypeVo
class DrameTypeVoModel: Codable {
    var drameName, drameType: String?

    enum CodingKeys: String, CodingKey {
         case drameName
         case drameType
     }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.drameName = try? container.decodeIfPresent(String.self, forKey: CodingKeys.drameName)
        self.drameType = try? container.decodeIfPresent(String.self, forKey: CodingKeys.drameType)
    }
}

// MARK: - TagList
class TagListModel: Codable {
    var id: Int?
    var name: String?

    enum CodingKeys: String, CodingKey {
         case id
         case name
     }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try? container.decodeIfPresent(Int.self, forKey: CodingKeys.id)
        self.name = try? container.decodeIfPresent(String.self, forKey: CodingKeys.name)
    }
}

// MARK: - upInfoModel
class upInfoModel: Codable {
    var enable: Bool?
    var upID: Int?
    var upImgURL: String?
    var upName: String?

    enum CodingKeys: String, CodingKey {
        case enable
        case upID = "upId"
        case upImgURL = "upImgUrl"
        case upName
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.enable = try? container.decodeIfPresent(Bool.self, forKey: CodingKeys.enable)
        self.upID = try? container.decodeIfPresent(Int.self, forKey: CodingKeys.upID)
        self.upImgURL = try? container.decodeIfPresent(String.self, forKey: CodingKeys.upImgURL)
        self.upName = try? container.decodeIfPresent(String.self, forKey: CodingKeys.upName)
    }
}

// MARK: - DefinitionListModel
class DefinitionListModel: Codable {
    var code: String?
    var descriptionField: String?
    var fullDescription: String?
    
    enum CodingKeys: String, CodingKey {
        case code
        case descriptionField
        case fullDescription
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.code = try? container.decodeIfPresent(String.self, forKey: CodingKeys.code)
        self.descriptionField = try? container.decodeIfPresent(String.self, forKey: CodingKeys.descriptionField)
        self.fullDescription = try? container.decodeIfPresent(String.self, forKey: CodingKeys.fullDescription)
    }
}
