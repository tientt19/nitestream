//
//	List.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class TopSearchData{

	var cover : String!
	var domainType : Int!
	var id : String!
	var title : String!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		cover = dictionary["cover"] as? String
		domainType = dictionary["domainType"] as? Int
		id = dictionary["id"] as? String
		title = dictionary["title"] as? String
	}
    
    required init(fromSearchingData dictionary: SearchResult) {
        cover = dictionary.coverHorizontalUrl
        domainType = dictionary.domainType
        id = dictionary.id
        title = dictionary.name
    }

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if cover != nil{
			dictionary["cover"] = cover
		}
		if domainType != nil{
			dictionary["domainType"] = domainType
		}
		if id != nil{
			dictionary["id"] = id
		}
		if title != nil{
			dictionary["title"] = title
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         cover = aDecoder.decodeObject(forKey: "cover") as? String
         domainType = aDecoder.decodeObject(forKey: "domainType") as? Int
         id = aDecoder.decodeObject(forKey: "id") as? String
         title = aDecoder.decodeObject(forKey: "title") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if cover != nil{
			aCoder.encode(cover, forKey: "cover")
		}
		if domainType != nil{
			aCoder.encode(domainType, forKey: "domainType")
		}
		if id != nil{
			aCoder.encode(id, forKey: "id")
		}
		if title != nil{
			aCoder.encode(title, forKey: "title")
		}

	}

}
