

import Foundation


class RecommendContentVOList{

	var category : Int!
	var contentType : String!
	var id : Int!
	var imageUrl : String!
	var jumpAddress : String!
	var jumpType : String!
	var needLogin : Bool!
	var resourceNum : Int!
	var resourceStatus : Int!
	var showMark : Bool!
	var title : String!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		category = dictionary["category"] as? Int
		contentType = dictionary["contentType"] as? String
		id = dictionary["id"] as? Int
		imageUrl = dictionary["imageUrl"] as? String
		jumpAddress = dictionary["jumpAddress"] as? String
		jumpType = dictionary["jumpType"] as? String
		needLogin = dictionary["needLogin"] as? Bool
		resourceNum = dictionary["resourceNum"] as? Int
		resourceStatus = dictionary["resourceStatus"] as? Int
		showMark = dictionary["showMark"] as? Bool
		title = dictionary["title"] as? String
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if category != nil{
			dictionary["category"] = category
		}
		if contentType != nil{
			dictionary["contentType"] = contentType
		}
		if id != nil{
			dictionary["id"] = id
		}
		if imageUrl != nil{
			dictionary["imageUrl"] = imageUrl
		}
		if jumpAddress != nil{
			dictionary["jumpAddress"] = jumpAddress
		}
		if jumpType != nil{
			dictionary["jumpType"] = jumpType
		}
		if needLogin != nil{
			dictionary["needLogin"] = needLogin
		}
		if resourceNum != nil{
			dictionary["resourceNum"] = resourceNum
		}
		if resourceStatus != nil{
			dictionary["resourceStatus"] = resourceStatus
		}
		if showMark != nil{
			dictionary["showMark"] = showMark
		}
		if title != nil{
			dictionary["title"] = title
		}
		return dictionary
	}

//    /**
//    * NSCoding required initializer.
//    * Fills the data from the passed decoder
//    */
//    @objc required init(coder aDecoder: NSCoder)
//	{
//         category = aDecoder.decodeObject(forKey: "category") as? Int
//         contentType = aDecoder.decodeObject(forKey: "contentType") as? String
//         id = aDecoder.decodeObject(forKey: "id") as? Int
//         imageUrl = aDecoder.decodeObject(forKey: "imageUrl") as? String
//         jumpAddress = aDecoder.decodeObject(forKey: "jumpAddress") as? String
//         jumpType = aDecoder.decodeObject(forKey: "jumpType") as? String
//         needLogin = aDecoder.decodeObject(forKey: "needLogin") as? Bool
//         resourceNum = aDecoder.decodeObject(forKey: "resourceNum") as? Int
//         resourceStatus = aDecoder.decodeObject(forKey: "resourceStatus") as? Int
//         showMark = aDecoder.decodeObject(forKey: "showMark") as? Bool
//         title = aDecoder.decodeObject(forKey: "title") as? String
//
//	}
//
//    /**
//    * NSCoding required method.
//    * Encodes mode properties into the decoder
//    */
//    @objc func encode(with aCoder: NSCoder)
//	{
//		if category != nil{
//			aCoder.encode(category, forKey: "category")
//		}
//		if contentType != nil{
//			aCoder.encode(contentType, forKey: "contentType")
//		}
//		if id != nil{
//			aCoder.encode(id, forKey: "id")
//		}
//		if imageUrl != nil{
//			aCoder.encode(imageUrl, forKey: "imageUrl")
//		}
//		if jumpAddress != nil{
//			aCoder.encode(jumpAddress, forKey: "jumpAddress")
//		}
//		if jumpType != nil{
//			aCoder.encode(jumpType, forKey: "jumpType")
//		}
//		if needLogin != nil{
//			aCoder.encode(needLogin, forKey: "needLogin")
//		}
//		if resourceNum != nil{
//			aCoder.encode(resourceNum, forKey: "resourceNum")
//		}
//		if resourceStatus != nil{
//			aCoder.encode(resourceStatus, forKey: "resourceStatus")
//		}
//		if showMark != nil{
//			aCoder.encode(showMark, forKey: "showMark")
//		}
//		if title != nil{
//			aCoder.encode(title, forKey: "title")
//		}
//
//	}

}
