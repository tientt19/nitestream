//
//  VideoShortModel.swift
//  ChuTeHoiDongQuanTri
//
//  Created by Valerian on 30/05/2022.
//

import Foundation
import IGListKit


class VideoShortModel: ListDiffable {
    private var identifier: String = UUID().uuidString
    var videoShortData: [TikTokModel]?
    var reviewData: [ReviewMedia]?
    
    init(_ listVideo: [TikTokModel], _ listReview: [ReviewMedia] ) {
        self.videoShortData = listVideo
        self.reviewData = listReview
    }
    
    
    func diffIdentifier() -> NSObjectProtocol {
        return identifier as NSString
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let object = object as? VideoShortModel else {
            return false
        }
        
        return self.identifier == object.identifier
    }
}
