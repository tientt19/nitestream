//
//	SearchResult.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class SearchResult : NSObject, NSCoding{

	var areas : [Area]!
	var categoryTag : [Area]!
	var coverHorizontalUrl : String!
	var coverVerticalUrl : String!
	var domainType : Int!
	var dramaType : DramaType!
	var duration : String!
	var id : String!
	var name : String!
	var releaseTime : String!
	var sort : String!
	var upInfo : SearchingUpInfo!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		areas = [Area]()
		if let areasArray = dictionary["areas"] as? [[String:Any]]{
			for dic in areasArray{
				let value = Area(fromDictionary: dic)
				areas.append(value)
			}
		}
		categoryTag = [Area]()
		if let categoryTagArray = dictionary["categoryTag"] as? [[String:Any]]{
			for dic in categoryTagArray{
				let value = Area(fromDictionary: dic)
				categoryTag.append(value)
			}
		}
		coverHorizontalUrl = dictionary["coverHorizontalUrl"] as? String
		coverVerticalUrl = dictionary["coverVerticalUrl"] as? String
		domainType = dictionary["domainType"] as? Int
		if let dramaTypeData = dictionary["dramaType"] as? [String:Any]{
			dramaType = DramaType(fromDictionary: dramaTypeData)
		}
		duration = dictionary["duration"] as? String
		id = dictionary["id"] as? String
		name = dictionary["name"] as? String
		releaseTime = dictionary["releaseTime"] as? String
		sort = dictionary["sort"] as? String
		if let upInfoData = dictionary["upInfo"] as? [String:Any]{
			upInfo = SearchingUpInfo(fromDictionary: upInfoData)
		}
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if areas != nil{
			var dictionaryElements = [[String:Any]]()
			for areasElement in areas {
				dictionaryElements.append(areasElement.toDictionary())
			}
			dictionary["areas"] = dictionaryElements
		}
		if categoryTag != nil{
			var dictionaryElements = [[String:Any]]()
			for categoryTagElement in categoryTag {
				dictionaryElements.append(categoryTagElement.toDictionary())
			}
			dictionary["categoryTag"] = dictionaryElements
		}
		if coverHorizontalUrl != nil{
			dictionary["coverHorizontalUrl"] = coverHorizontalUrl
		}
		if coverVerticalUrl != nil{
			dictionary["coverVerticalUrl"] = coverVerticalUrl
		}
		if domainType != nil{
			dictionary["domainType"] = domainType
		}
		if dramaType != nil{
			dictionary["dramaType"] = dramaType.toDictionary()
		}
		if duration != nil{
			dictionary["duration"] = duration
		}
		if id != nil{
			dictionary["id"] = id
		}
		if name != nil{
			dictionary["name"] = name
		}
		if releaseTime != nil{
			dictionary["releaseTime"] = releaseTime
		}
		if sort != nil{
			dictionary["sort"] = sort
		}
		if upInfo != nil{
			dictionary["upInfo"] = upInfo.toDictionary()
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         areas = aDecoder.decodeObject(forKey :"areas") as? [Area]
         categoryTag = aDecoder.decodeObject(forKey :"categoryTag") as? [Area]
         coverHorizontalUrl = aDecoder.decodeObject(forKey: "coverHorizontalUrl") as? String
         coverVerticalUrl = aDecoder.decodeObject(forKey: "coverVerticalUrl") as? String
         domainType = aDecoder.decodeObject(forKey: "domainType") as? Int
         dramaType = aDecoder.decodeObject(forKey: "dramaType") as? DramaType
         duration = aDecoder.decodeObject(forKey: "duration") as? String
         id = aDecoder.decodeObject(forKey: "id") as? String
         name = aDecoder.decodeObject(forKey: "name") as? String
         releaseTime = aDecoder.decodeObject(forKey: "releaseTime") as? String
         sort = aDecoder.decodeObject(forKey: "sort") as? String
         upInfo = aDecoder.decodeObject(forKey: "upInfo") as? SearchingUpInfo

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if areas != nil{
			aCoder.encode(areas, forKey: "areas")
		}
		if categoryTag != nil{
			aCoder.encode(categoryTag, forKey: "categoryTag")
		}
		if coverHorizontalUrl != nil{
			aCoder.encode(coverHorizontalUrl, forKey: "coverHorizontalUrl")
		}
		if coverVerticalUrl != nil{
			aCoder.encode(coverVerticalUrl, forKey: "coverVerticalUrl")
		}
		if domainType != nil{
			aCoder.encode(domainType, forKey: "domainType")
		}
		if dramaType != nil{
			aCoder.encode(dramaType, forKey: "dramaType")
		}
		if duration != nil{
			aCoder.encode(duration, forKey: "duration")
		}
		if id != nil{
			aCoder.encode(id, forKey: "id")
		}
		if name != nil{
			aCoder.encode(name, forKey: "name")
		}
		if releaseTime != nil{
			aCoder.encode(releaseTime, forKey: "releaseTime")
		}
		if sort != nil{
			aCoder.encode(sort, forKey: "sort")
		}
		if upInfo != nil{
			aCoder.encode(upInfo, forKey: "upInfo")
		}

	}

}
