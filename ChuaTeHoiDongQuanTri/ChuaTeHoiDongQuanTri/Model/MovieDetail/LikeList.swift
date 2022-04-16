//
//	LikeList.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class LikeList : NSObject, NSCoding{

	var areaList : [AreaList]!
	var areaNameList : [String]!
	var category : Int!
	var coverHorizontalUrl : String!
	var coverVerticalUrl : String!
	var drameTypeVo : AnyObject!
	var id : String!
	var name : String!
	var score : Float!
	var tagList : [AreaList]!
	var tagNameList : [String]!
	var upImgUrl : String!
	var upName : String!
	var year : Int!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		areaList = [AreaList]()
		if let areaListArray = dictionary["areaList"] as? [[String:Any]]{
			for dic in areaListArray{
				let value = AreaList(fromDictionary: dic)
				areaList.append(value)
			}
		}
		areaNameList = dictionary["areaNameList"] as? [String]
		category = dictionary["category"] as? Int
		coverHorizontalUrl = dictionary["coverHorizontalUrl"] as? String
		coverVerticalUrl = dictionary["coverVerticalUrl"] as? String
        drameTypeVo = dictionary["drameTypeVo"] as AnyObject?
		id = dictionary["id"] as? String
		name = dictionary["name"] as? String
		score = dictionary["score"] as? Float
		tagList = [AreaList]()
		if let tagListArray = dictionary["tagList"] as? [[String:Any]]{
			for dic in tagListArray{
				let value = AreaList(fromDictionary: dic)
				tagList.append(value)
			}
		}
		tagNameList = dictionary["tagNameList"] as? [String]
		upImgUrl = dictionary["upImgUrl"] as? String
		upName = dictionary["upName"] as? String
		year = dictionary["year"] as? Int
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if areaList != nil{
			var dictionaryElements = [[String:Any]]()
			for areaListElement in areaList {
				dictionaryElements.append(areaListElement.toDictionary())
			}
			dictionary["areaList"] = dictionaryElements
		}
		if areaNameList != nil{
			dictionary["areaNameList"] = areaNameList
		}
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
		if score != nil{
			dictionary["score"] = score
		}
		if tagList != nil{
			var dictionaryElements = [[String:Any]]()
			for tagListElement in tagList {
				dictionaryElements.append(tagListElement.toDictionary())
			}
			dictionary["tagList"] = dictionaryElements
		}
		if tagNameList != nil{
			dictionary["tagNameList"] = tagNameList
		}
		if upImgUrl != nil{
			dictionary["upImgUrl"] = upImgUrl
		}
		if upName != nil{
			dictionary["upName"] = upName
		}
		if year != nil{
			dictionary["year"] = year
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         areaList = aDecoder.decodeObject(forKey :"areaList") as? [AreaList]
         areaNameList = aDecoder.decodeObject(forKey: "areaNameList") as? [String]
         category = aDecoder.decodeObject(forKey: "category") as? Int
         coverHorizontalUrl = aDecoder.decodeObject(forKey: "coverHorizontalUrl") as? String
         coverVerticalUrl = aDecoder.decodeObject(forKey: "coverVerticalUrl") as? String
        drameTypeVo = aDecoder.decodeObject(forKey: "drameTypeVo") as AnyObject?
         id = aDecoder.decodeObject(forKey: "id") as? String
         name = aDecoder.decodeObject(forKey: "name") as? String
         score = aDecoder.decodeObject(forKey: "score") as? Float
         tagList = aDecoder.decodeObject(forKey :"tagList") as? [AreaList]
         tagNameList = aDecoder.decodeObject(forKey: "tagNameList") as? [String]
         upImgUrl = aDecoder.decodeObject(forKey: "upImgUrl") as? String
         upName = aDecoder.decodeObject(forKey: "upName") as? String
         year = aDecoder.decodeObject(forKey: "year") as? Int

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if areaList != nil{
			aCoder.encode(areaList, forKey: "areaList")
		}
		if areaNameList != nil{
			aCoder.encode(areaNameList, forKey: "areaNameList")
		}
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
		if score != nil{
			aCoder.encode(score, forKey: "score")
		}
		if tagList != nil{
			aCoder.encode(tagList, forKey: "tagList")
		}
		if tagNameList != nil{
			aCoder.encode(tagNameList, forKey: "tagNameList")
		}
		if upImgUrl != nil{
			aCoder.encode(upImgUrl, forKey: "upImgUrl")
		}
		if upName != nil{
			aCoder.encode(upName, forKey: "upName")
		}
		if year != nil{
			aCoder.encode(year, forKey: "year")
		}

	}

}
