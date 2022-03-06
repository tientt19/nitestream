//
//	Data.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

class LinkMedia{

	var businessType : Int!
	var currentDefinition : String!
	var episodeId : String!
	var mediaUrl : String!
	var totalDuration : Int!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		businessType = dictionary["businessType"] as? Int
		currentDefinition = dictionary["currentDefinition"] as? String
		episodeId = dictionary["episodeId"] as? String
		mediaUrl = dictionary["mediaUrl"] as? String
		totalDuration = dictionary["totalDuration"] as? Int
	}

}
