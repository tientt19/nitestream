//
//	UpInfo.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class SearchingUpInfo : NSObject, NSCoding{

	var enable : Bool!
	var upId : Int!
	var upImgUrl : String!
	var upName : String!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		enable = dictionary["enable"] as? Bool
		upId = dictionary["upId"] as? Int
		upImgUrl = dictionary["upImgUrl"] as? String
		upName = dictionary["upName"] as? String
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if enable != nil{
			dictionary["enable"] = enable
		}
		if upId != nil{
			dictionary["upId"] = upId
		}
		if upImgUrl != nil{
			dictionary["upImgUrl"] = upImgUrl
		}
		if upName != nil{
			dictionary["upName"] = upName
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         enable = aDecoder.decodeObject(forKey: "enable") as? Bool
         upId = aDecoder.decodeObject(forKey: "upId") as? Int
         upImgUrl = aDecoder.decodeObject(forKey: "upImgUrl") as? String
         upName = aDecoder.decodeObject(forKey: "upName") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if enable != nil{
			aCoder.encode(enable, forKey: "enable")
		}
		if upId != nil{
			aCoder.encode(upId, forKey: "upId")
		}
		if upImgUrl != nil{
			aCoder.encode(upImgUrl, forKey: "upImgUrl")
		}
		if upName != nil{
			aCoder.encode(upName, forKey: "upName")
		}

	}

}
