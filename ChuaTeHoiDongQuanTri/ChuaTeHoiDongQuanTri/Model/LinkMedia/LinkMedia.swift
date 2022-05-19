//
//	Data.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation
import IGListKit

class LinkMedia: ListDiffable{
    private var identifier: String = UUID().uuidString

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
    
    func diffIdentifier() -> NSObjectProtocol {
        return identifier as NSString
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let object = object as? LinkMedia else {
            return false
        }
        
        return self.identifier == object.identifier
    }
}
