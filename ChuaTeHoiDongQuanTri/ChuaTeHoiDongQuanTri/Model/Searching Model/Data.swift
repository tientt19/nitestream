//
//	Data.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class Data : NSObject, NSCoding{

	var searchResults : [SearchResult]!
	var searchType : String!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		searchResults = [SearchResult]()
		if let searchResultsArray = dictionary["searchResults"] as? [[String:Any]]{
			for dic in searchResultsArray{
				let value = SearchResult(fromDictionary: dic)
				searchResults.append(value)
			}
		}
		searchType = dictionary["searchType"] as? String
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if searchResults != nil{
			var dictionaryElements = [[String:Any]]()
			for searchResultsElement in searchResults {
				dictionaryElements.append(searchResultsElement.toDictionary())
			}
			dictionary["searchResults"] = dictionaryElements
		}
		if searchType != nil{
			dictionary["searchType"] = searchType
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         searchResults = aDecoder.decodeObject(forKey :"searchResults") as? [SearchResult]
         searchType = aDecoder.decodeObject(forKey: "searchType") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if searchResults != nil{
			aCoder.encode(searchResults, forKey: "searchResults")
		}
		if searchType != nil{
			aCoder.encode(searchType, forKey: "searchType")
		}

	}

}