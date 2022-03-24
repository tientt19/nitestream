//
//  ReviewMedia.swift
//  ChuaTeHoiDongQuanTri
//
//  Created by Valerian on 24/03/2022.
//

import Foundation

class ReviewMedia {

    var category : Int!
    var coverHorizontalUrl : String!
    var coverVerticalUrl : String!
    var duration : Int!
    var id : String!
    var introduction : String!
    var like : Bool!
    var likeCount : Int!
    var mediaInfo : MediaInfo!
    var name : String!
    var refList : [RefList]!
    var upInfo : UpInfo!

    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
  
        category = dictionary["category"] as? Int
        coverHorizontalUrl = dictionary["coverHorizontalUrl"] as? String
        coverVerticalUrl = dictionary["coverVerticalUrl"] as? String
        id = dictionary["id"] as? String
        introduction = dictionary["introduction"] as? String
        duration = dictionary["duration"] as? Int
        name = dictionary["name"] as? String
        refList = [RefList]()
        like = dictionary["like"] as? Bool
        likeCount = dictionary["likeCount"] as? Int
        
        if let refListArray = dictionary["refList"] as? [[String:Any]]{
            for dic in refListArray{
                let value = RefList(fromDictionary: dic)
                refList.append(value)
            }
        }
        
        if let dic = dictionary["mediaInfo"] as? [String:Any]{
            mediaInfo = MediaInfo(fromDictionary: dic)
        }
        
        if let dic = dictionary["upInfo"] as? [String:Any]{
            upInfo = UpInfo(fromDictionary: dic)
        }
    }
}
