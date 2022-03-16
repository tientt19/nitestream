
import Foundation


class RecommendItem {

	var bannerProportion : AnyObject!
	var blockGroupNum : AnyObject!
	var coverType : Int!
	var homeSectionId : Int!
	var homeSectionName : String!
	var homeSectionType : String!
	var recommendContentVOList : [RecommendContentVOList]!
	var refId : Int!
	var refRedirectUrl : String!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
        bannerProportion = dictionary["bannerProportion"] as AnyObject?
        blockGroupNum = dictionary["blockGroupNum"] as AnyObject?
		coverType = dictionary["coverType"] as? Int
		homeSectionId = dictionary["homeSectionId"] as? Int
		homeSectionName = dictionary["homeSectionName"] as? String
		homeSectionType = dictionary["homeSectionType"] as? String
		recommendContentVOList = [RecommendContentVOList]()
		if let recommendContentVOListArray = dictionary["recommendContentVOList"] as? [[String:Any]]{
			for dic in recommendContentVOListArray{
				let value = RecommendContentVOList(fromDictionary: dic)
				recommendContentVOList.append(value)
			}
		}
		refId = dictionary["refId"] as? Int
		refRedirectUrl = dictionary["refRedirectUrl"] as? String
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if bannerProportion != nil{
			dictionary["bannerProportion"] = bannerProportion
		}
		if blockGroupNum != nil{
			dictionary["blockGroupNum"] = blockGroupNum
		}
		if coverType != nil{
			dictionary["coverType"] = coverType
		}
		if homeSectionId != nil{
			dictionary["homeSectionId"] = homeSectionId
		}
		if homeSectionName != nil{
			dictionary["homeSectionName"] = homeSectionName
		}
		if homeSectionType != nil{
			dictionary["homeSectionType"] = homeSectionType
		}
		if recommendContentVOList != nil{
			var dictionaryElements = [[String:Any]]()
			for recommendContentVOListElement in recommendContentVOList {
				dictionaryElements.append(recommendContentVOListElement.toDictionary())
			}
			dictionary["recommendContentVOList"] = dictionaryElements
		}
		if refId != nil{
			dictionary["refId"] = refId
		}
		if refRedirectUrl != nil{
			dictionary["refRedirectUrl"] = refRedirectUrl
		}
		return dictionary
	}

//    /**
//    * NSCoding required initializer.
//    * Fills the data from the passed decoder
//    */
//    @objc required init(coder aDecoder: NSCoder)
//	{
//         bannerProportion = aDecoder.decodeObject(forKey: "bannerProportion") as? AnyObject
//         blockGroupNum = aDecoder.decodeObject(forKey: "blockGroupNum") as? AnyObject
//         coverType = aDecoder.decodeObject(forKey: "coverType") as? Int
//         homeSectionId = aDecoder.decodeObject(forKey: "homeSectionId") as? Int
//         homeSectionName = aDecoder.decodeObject(forKey: "homeSectionName") as? String
//         homeSectionType = aDecoder.decodeObject(forKey: "homeSectionType") as? String
//         recommendContentVOList = aDecoder.decodeObject(forKey :"recommendContentVOList") as? [RecommendContentVOList]
//         refId = aDecoder.decodeObject(forKey: "refId") as? Int
//         refRedirectUrl = aDecoder.decodeObject(forKey: "refRedirectUrl") as? String
//
//	}
//
//    /**
//    * NSCoding required method.
//    * Encodes mode properties into the decoder
//    */
//    @objc func encode(with aCoder: NSCoder)
//	{
//		if bannerProportion != nil{
//			aCoder.encode(bannerProportion, forKey: "bannerProportion")
//		}
//		if blockGroupNum != nil{
//			aCoder.encode(blockGroupNum, forKey: "blockGroupNum")
//		}
//		if coverType != nil{
//			aCoder.encode(coverType, forKey: "coverType")
//		}
//		if homeSectionId != nil{
//			aCoder.encode(homeSectionId, forKey: "homeSectionId")
//		}
//		if homeSectionName != nil{
//			aCoder.encode(homeSectionName, forKey: "homeSectionName")
//		}
//		if homeSectionType != nil{
//			aCoder.encode(homeSectionType, forKey: "homeSectionType")
//		}
//		if recommendContentVOList != nil{
//			aCoder.encode(recommendContentVOList, forKey: "recommendContentVOList")
//		}
//		if refId != nil{
//			aCoder.encode(refId, forKey: "refId")
//		}
//		if refRedirectUrl != nil{
//			aCoder.encode(refRedirectUrl, forKey: "refRedirectUrl")
//		}
//
//	}

}