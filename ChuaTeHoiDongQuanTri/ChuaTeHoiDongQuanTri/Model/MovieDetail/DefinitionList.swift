//
//	DefinitionList.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class DefinitionList : NSObject, NSCoding{

	var code : String!
	var descriptionField : String!
	var fullDescription : String!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		code = dictionary["code"] as? String
		descriptionField = dictionary["description"] as? String
		fullDescription = dictionary["fullDescription"] as? String
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if code != nil{
			dictionary["code"] = code
		}
		if descriptionField != nil{
			dictionary["description"] = descriptionField
		}
		if fullDescription != nil{
			dictionary["fullDescription"] = fullDescription
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         code = aDecoder.decodeObject(forKey: "code") as? String
         descriptionField = aDecoder.decodeObject(forKey: "description") as? String
         fullDescription = aDecoder.decodeObject(forKey: "fullDescription") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if code != nil{
			aCoder.encode(code, forKey: "code")
		}
		if descriptionField != nil{
			aCoder.encode(descriptionField, forKey: "description")
		}
		if fullDescription != nil{
			aCoder.encode(fullDescription, forKey: "fullDescription")
		}

	}
}
