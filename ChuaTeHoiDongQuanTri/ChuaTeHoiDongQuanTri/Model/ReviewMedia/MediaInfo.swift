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
        if resourceType != nil{
            dictionary["resourceType"] = resourceType
        }
        if subtitlingList != nil{
            dictionary["subtitlingList"] = subtitlingList
        }
        return dictionary
    }

}
