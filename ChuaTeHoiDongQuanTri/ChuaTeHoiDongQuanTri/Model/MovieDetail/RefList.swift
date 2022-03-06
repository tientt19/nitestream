//
//	RefList.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class RefList : NSObject, NSCoding{

	var category : Int!
	var coverHorizontalUrl : String!
	var coverVerticalUrl : String!
	var drameTypeVo : AnyObject!
	var id : String!
	var name : String!
	var seriesNo : Int!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		category = dictionary["category"] as? Int
		coverHorizontalUrl = dictionary["coverHorizontalUrl"] as? String
		coverVerticalUrl = dictionary["coverVerticalUrl"] as? String
        drameTypeVo = dictionary["drameTypeVo"] as AnyObject?
		id = dictionary["id"] as? String
		name = dictionary["name"] as? String
		seriesNo = dictionary["seriesNo"] as? Int
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
		if coverHorizontalUrl != nil{
			dictionary["coverHorizontalUrl"] = coverHorizontalUrl
		}
		if coverVerticalUrl != nil{
			dictionary["coverVerticalUrl"] = coverVerticalUrl
		}
		if drameTypeVo != nil{
			dictionary["drameTypeVo"] = drameTypeVo
		}
		if id != nil{
			dictionary["id"] = id
		}
		if name != nil{
			dictionary["name"] = name
		}
		if seriesNo != nil{
			dictionary["seriesNo"] = seriesNo
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         category = aDecoder.decodeObject(forKey: "category") as? Int
         coverHorizontalUrl = aDecoder.decodeObject(forKey: "coverHorizontalUrl") as? String
         coverVerticalUrl = aDecoder.decodeObject(forKey: "coverVerticalUrl") as? String
        drameTypeVo = aDecoder.decodeObject(forKey: "drameTypeVo") as AnyObject?
         id = aDecoder.decodeObject(forKey: "id") as? String
         name = aDecoder.decodeObject(forKey: "name") as? String
         seriesNo = aDecoder.decodeObject(forKey: "seriesNo") as? Int

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if category != nil{
			aCoder.encode(category, forKey: "category")
		}
		if coverHorizontalUrl != nil{
			aCoder.encode(coverHorizontalUrl, forKey: "coverHorizontalUrl")
		}
		if coverVerticalUrl != nil{
			aCoder.encode(coverVerticalUrl, forKey: "coverVerticalUrl")
		}
		if drameTypeVo != nil{
			aCoder.encode(drameTypeVo, forKey: "drameTypeVo")
		}
		if id != nil{
			aCoder.encode(id, forKey: "id")
		}
		if name != nil{
			aCoder.encode(name, forKey: "name")
		}
		if seriesNo != nil{
			aCoder.encode(seriesNo, forKey: "seriesNo")
		}

	}

}
