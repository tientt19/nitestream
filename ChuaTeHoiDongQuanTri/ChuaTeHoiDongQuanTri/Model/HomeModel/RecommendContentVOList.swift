

import Foundation
import IGListKit

class RecommendContentVOList: ListDiffable {

    private var identifier: String = UUID().uuidString

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

    func diffIdentifier() -> NSObjectProtocol {
        return identifier as NSString
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let object = object as? RecommendContentVOList else {
            return false
        }
        
        return self.identifier == object.identifier
    }

}
