
import Foundation
import IGListKit

class RecommendItem: ListDiffable {
    
    private var identifier: String = UUID().uuidString

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
    
    
    func diffIdentifier() -> NSObjectProtocol {
        return identifier as NSString
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let object = object as? RecommendItem else {
            return false
        }
        
        return self.identifier == object.identifier
    }
}
