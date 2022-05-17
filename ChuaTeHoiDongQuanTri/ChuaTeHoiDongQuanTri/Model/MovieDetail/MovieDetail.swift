//
//	Data.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation
import IGListKit

class MovieDetail: ListDiffable{

    private var identifier: String = UUID().uuidString
    
	var aliasName : String!
	var areaList : [AreaList]!
	var areaNameList : [String]!
	var category : Int!
	var collect : Bool!
	var coverHorizontalUrl : String!
	var coverVerticalUrl : String!
	var drameTypeVo : DrameTypeVo!
	var episodeCount : AnyObject!
	var episodeVo : [EpisodeVo]!
	var id : String!
	var introduction : String!
	var likeList : [LikeList]!
	var name : String!
	var refList : [RefList]!
	var reserved : Bool!
	var score : Float!
	var seriesNo : Int!
	var showSetName : Bool!
	var tagList : [AreaList]!
	var tagNameList : [String]!
	var translateType : Int!
	var upInfo : UpInfo!
	var updateInfo : AnyObject!
	var year : Int!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		aliasName = dictionary["aliasName"] as? String
		areaList = [AreaList]()
		if let areaListArray = dictionary["areaList"] as? [[String:Any]]{
			for dic in areaListArray{
				let value = AreaList(fromDictionary: dic)
				areaList.append(value)
			}
		}
		areaNameList = dictionary["areaNameList"] as? [String]
		category = dictionary["category"] as? Int
		collect = dictionary["collect"] as? Bool
		coverHorizontalUrl = dictionary["coverHorizontalUrl"] as? String
		coverVerticalUrl = dictionary["coverVerticalUrl"] as? String
		if let drameTypeVoData = dictionary["drameTypeVo"] as? [String:Any]{
			drameTypeVo = DrameTypeVo(fromDictionary: drameTypeVoData)
		}
        episodeCount = dictionary["episodeCount"] as AnyObject?
		episodeVo = [EpisodeVo]()
		if let episodeVoArray = dictionary["episodeVo"] as? [[String:Any]]{
			for dic in episodeVoArray{
				let value = EpisodeVo(fromDictionary: dic)
				episodeVo.append(value)
			}
		}
		id = dictionary["id"] as? String
		introduction = dictionary["introduction"] as? String
		likeList = [LikeList]()
		if let likeListArray = dictionary["likeList"] as? [[String:Any]]{
			for dic in likeListArray{
				let value = LikeList(fromDictionary: dic)
				likeList.append(value)
			}
		}
		name = dictionary["name"] as? String
		refList = [RefList]()
		if let refListArray = dictionary["refList"] as? [[String:Any]]{
			for dic in refListArray{
				let value = RefList(fromDictionary: dic)
				refList.append(value)
			}
		}
		reserved = dictionary["reserved"] as? Bool
		score = dictionary["score"] as? Float
		seriesNo = dictionary["seriesNo"] as? Int
		showSetName = dictionary["showSetName"] as? Bool
		tagList = [AreaList]()
		if let tagListArray = dictionary["tagList"] as? [[String:Any]]{
			for dic in tagListArray{
				let value = AreaList(fromDictionary: dic)
				tagList.append(value)
			}
		}
		tagNameList = dictionary["tagNameList"] as? [String]
		translateType = dictionary["translateType"] as? Int
		if let upInfoData = dictionary["upInfo"] as? [String:Any]{
			upInfo = UpInfo(fromDictionary: upInfoData)
		}
        updateInfo = dictionary["updateInfo"] as AnyObject?
		year = dictionary["year"] as? Int
	}

    func diffIdentifier() -> NSObjectProtocol {
        return identifier as NSString
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let object = object as? MovieDetail else {
            return false
        }
        
        return self.identifier == object.identifier
    }
}


// MARK: - MovieInfo ListDiffable
class MovieInfo: ListDiffable {
    private var identifier: String = UUID().uuidString
    
    var introduction : String!
    var score : Float!
    var year : Int!
    var name : String!


    init(from movieDetail: MovieDetail) {
        self.introduction = movieDetail.introduction
        self.score = movieDetail.score
        self.year = movieDetail.year
        self.name = movieDetail.name
    }
    
    func diffIdentifier() -> NSObjectProtocol {
        return identifier as NSString
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let object = object as? MovieInfo else {
            return false
        }
        
        return self.identifier == object.identifier
    }
}
