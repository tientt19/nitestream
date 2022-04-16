//
//  TikTokModel.swift
//  ChuTeHoiDongQuanTri
//
//  Created by Valerian on 04/04/2022.
//

import Foundation

class TikTokModel {
    var businessType : Int!
    var currentDefinition : String!
    var episodeId : String!
    var mediaUrl : String!
    var totalDuration : Int!

    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        businessType = dictionary["businessType"] as? Int
        currentDefinition = dictionary["currentDefinition"] as? String
        episodeId = dictionary["episodeId"] as? String
        mediaUrl = dictionary["mediaUrl"] as? String
        totalDuration = dictionary["totalDuration"] as? Int
    }

}
