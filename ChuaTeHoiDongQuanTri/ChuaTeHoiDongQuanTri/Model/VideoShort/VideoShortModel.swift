//
//  VideoShortModel.swift
//  ChuTeHoiDongQuanTri
//
//  Created by Valerian on 30/05/2022.
//

import Foundation
import IGListKit

class VideoShortModel: ListDiffable {
    private var identifier: String = UUID().uuidString
    var videoShortData: [ShortVideoModel]?
    var reviewData: [ReviewShortVideoModel]?
    
    init(_ listVideo: [ShortVideoModel], _ listReview: [ReviewShortVideoModel] ) {
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
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.businessType = try? container.decodeIfPresent(Int.self, forKey: CodingKeys.businessType)
        self.currentDefinition = try? container.decodeIfPresent(String.self, forKey: CodingKeys.currentDefinition)
        self.episodeId = try? container.decodeIfPresent(String.self, forKey: CodingKeys.episodeId)
        self.mediaUrl = try? container.decodeIfPresent(String.self, forKey: CodingKeys.mediaUrl)
        self.totalDuration = try? container.decodeIfPresent(Int.self, forKey: CodingKeys.totalDuration)
    }
}

class ReviewShortVideoModel: Codable {
    var category: Int?
    var coverHorizontalUrl: String?
    var coverVerticalUrl: String?
    var duration: Int?
    var id: String?
    var introduction: String?
    var like: Bool?
    var likeCount: Int?
//    var mediaInfo: MediaInfo?
    var name: String?
//    var refList: [RefList]?
//    var upInfo: UpInfo?
    
    enum CodingKeys: String, CodingKey{
        case category
        case coverHorizontalUrl
        case coverVerticalUrl
        case duration
        case id
        case introduction
        case like
        case likeCount
//        case mediaInfo
        case name
//        case refList
//        case upInfo
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
//        self.mediaInfo = try? container.decodeIfPresent(MediaInfo.self, forKey: CodingKeys.mediaInfo)
        self.name = try? container.decodeIfPresent(String.self, forKey: CodingKeys.name)
//        self.refList = try? container.decodeIfPresent([RefList].self, forKey: CodingKeys.refList)
//        self.upInfo = try? container.decodeIfPresent(UpInfo.self, forKey: CodingKeys.upInfo)
    }
}
