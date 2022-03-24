//
//	MediaInfo.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

class MediaInfo{

	var definitionList : [DefinitionList]!
	var id : Int!
	var resourceType : Int!
	var subtitlingList : [AnyObject]!


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
		resourceType = dictionary["resourceType"] as? Int
		subtitlingList = dictionary["subtitlingList"] as? [AnyObject]
	}

}