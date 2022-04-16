//
//	SubtitlingList.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class SubtitlingList : NSObject, NSCoding{

	var language : String!
	var languageAbbr : String!
	var subtitlingUrl : String!
	var translateType : Int!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		language = dictionary["language"] as? String
		languageAbbr = dictionary["languageAbbr"] as? String
		subtitlingUrl = dictionary["subtitlingUrl"] as? String
		translateType = dictionary["translateType"] as? Int
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if language != nil{
			dictionary["language"] = language
		}
		if languageAbbr != nil{
			dictionary["languageAbbr"] = languageAbbr
		}
		if subtitlingUrl != nil{
			dictionary["subtitlingUrl"] = subtitlingUrl
		}
		if translateType != nil{
			dictionary["translateType"] = translateType
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         language = aDecoder.decodeObject(forKey: "language") as? String
         languageAbbr = aDecoder.decodeObject(forKey: "languageAbbr") as? String
         subtitlingUrl = aDecoder.decodeObject(forKey: "subtitlingUrl") as? String
         translateType = aDecoder.decodeObject(forKey: "translateType") as? Int

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if language != nil{
			aCoder.encode(language, forKey: "language")
		}
		if languageAbbr != nil{
			aCoder.encode(languageAbbr, forKey: "languageAbbr")
		}
		if subtitlingUrl != nil{
			aCoder.encode(subtitlingUrl, forKey: "subtitlingUrl")
		}
		if translateType != nil{
			aCoder.encode(translateType, forKey: "translateType")
		}

	}

}