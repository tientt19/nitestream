
import Foundation
import IGListKit

class HomePageModel: ListDiffable {
    private var identifier: String = UUID().uuidString

	var page : Int!
	var recommendItems : [RecommendItem]!
	var searchKeyWord : String!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		page = dictionary["page"] as? Int
		recommendItems = [RecommendItem]()
		if let recommendItemsArray = dictionary["recommendItems"] as? [[String:Any]]{
			for dic in recommendItemsArray{
				let value = RecommendItem(fromDictionary: dic)
				recommendItems.append(value)
			}
		}
		searchKeyWord = dictionary["searchKeyWord"] as? String
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if page != nil{
			dictionary["page"] = page
		}
		if recommendItems != nil{
			var dictionaryElements = [[String:Any]]()
			for recommendItemsElement in recommendItems {
				dictionaryElements.append(recommendItemsElement.toDictionary())
			}
			dictionary["recommendItems"] = dictionaryElements
		}
		if searchKeyWord != nil{
			dictionary["searchKeyWord"] = searchKeyWord
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         page = aDecoder.decodeObject(forKey: "page") as? Int
         recommendItems = aDecoder.decodeObject(forKey :"recommendItems") as? [RecommendItem]
         searchKeyWord = aDecoder.decodeObject(forKey: "searchKeyWord") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if page != nil{
			aCoder.encode(page, forKey: "page")
		}
		if recommendItems != nil{
			aCoder.encode(recommendItems, forKey: "recommendItems")
		}
		if searchKeyWord != nil{
			aCoder.encode(searchKeyWord, forKey: "searchKeyWord")
		}

	}
    
    func diffIdentifier() -> NSObjectProtocol {
        return identifier as NSString
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let object = object as? HomePageModel else {
            return false
        }
        
        return self.identifier == object.identifier
    }
}
