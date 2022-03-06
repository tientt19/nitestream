//
//	UpInfo.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

class UpInfo{

	var upId : Int!
	var upImgUrl : String!
	var upName : String!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		upId = dictionary["upId"] as? Int
		upImgUrl = dictionary["upImgUrl"] as? String
		upName = dictionary["upName"] as? String
	}

}