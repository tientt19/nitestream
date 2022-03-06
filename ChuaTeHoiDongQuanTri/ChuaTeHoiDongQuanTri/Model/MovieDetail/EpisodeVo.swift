//
//	EpisodeVo.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class EpisodeVo : NSObject, NSCoding{

	var definitionList : [DefinitionList]!
	var id : Int!
	var name : String!
	var resourceType : Int!
	var seriesNo : Int!
	var subtitlingList : [SubtitlingList]!
	var vid : String!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		definitionList = [DefinitionList]()
		if let definitionListArray = dictionary["definitionList"] as? [[String:Any]]{
			for dic in definitionListArray{
				let value = DefinitionList(fromDictionary: dic)
				definitionList.append(value)
			}
		}
		id = dictionary["id"] as? Int
		name = dictionary["name"] as? String
		resourceType = dictionary["resourceType"] as? Int
		seriesNo = dictionary["seriesNo"] as? Int
		subtitlingList = [SubtitlingList]()
		if let subtitlingListArray = dictionary["subtitlingList"] as? [[String:Any]]{
			for dic in subtitlingListArray{
				let value = SubtitlingList(fromDictionary: dic)
				subtitlingList.append(value)
			}
		}
		vid = dictionary["vid"] as? String
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if definitionList != nil{
			var dictionaryElements = [[String:Any]]()
			for definitionListElement in definitionList {
				dictionaryElements.append(definitionListElement.toDictionary())
			}
			dictionary["definitionList"] = dictionaryElements
		}
		if id != nil{
			dictionary["id"] = id
		}
		if name != nil{
			dictionary["name"] = name
		}
		if resourceType != nil{
			dictionary["resourceType"] = resourceType
		}
		if seriesNo != nil{
			dictionary["seriesNo"] = seriesNo
		}
		if subtitlingList != nil{
			var dictionaryElements = [[String:Any]]()
			for subtitlingListElement in subtitlingList {
				dictionaryElements.append(subtitlingListElement.toDictionary())
			}
			dictionary["subtitlingList"] = dictionaryElements
		}
		if vid != nil{
			dictionary["vid"] = vid
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         definitionList = aDecoder.decodeObject(forKey :"definitionList") as? [DefinitionList]
         id = aDecoder.decodeObject(forKey: "id") as? Int
         name = aDecoder.decodeObject(forKey: "name") as? String
         resourceType = aDecoder.decodeObject(forKey: "resourceType") as? Int
         seriesNo = aDecoder.decodeObject(forKey: "seriesNo") as? Int
         subtitlingList = aDecoder.decodeObject(forKey :"subtitlingList") as? [SubtitlingList]
         vid = aDecoder.decodeObject(forKey: "vid") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if definitionList != nil{
			aCoder.encode(definitionList, forKey: "definitionList")
		}
		if id != nil{
			aCoder.encode(id, forKey: "id")
		}
		if name != nil{
			aCoder.encode(name, forKey: "name")
		}
		if resourceType != nil{
			aCoder.encode(resourceType, forKey: "resourceType")
		}
		if seriesNo != nil{
			aCoder.encode(seriesNo, forKey: "seriesNo")
		}
		if subtitlingList != nil{
			aCoder.encode(subtitlingList, forKey: "subtitlingList")
		}
		if vid != nil{
			aCoder.encode(vid, forKey: "vid")
		}

	}

}