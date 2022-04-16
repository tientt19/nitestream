//
//	DrameTypeVo.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class DrameTypeVo : NSObject, NSCoding{

	var drameName : String!
	var drameType : String!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		drameName = dictionary["drameName"] as? String
		drameType = dictionary["drameType"] as? String
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if drameName != nil{
			dictionary["drameName"] = drameName
		}
		if drameType != nil{
			dictionary["drameType"] = drameType
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         drameName = aDecoder.decodeObject(forKey: "drameName") as? String
         drameType = aDecoder.decodeObject(forKey: "drameType") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if drameName != nil{
			aCoder.encode(drameName, forKey: "drameName")
		}
		if drameType != nil{
			aCoder.encode(drameType, forKey: "drameType")
		}

	}

}