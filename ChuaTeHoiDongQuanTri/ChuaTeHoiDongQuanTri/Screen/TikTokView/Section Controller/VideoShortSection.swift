//
//  VideoShortSection.swift
//  ChuTeHoiDongQuanTri
//
//  Created by Valerian on 27/05/2022.
//

import Foundation
import IGListKit

class VideoShortSectionController: ListSectionController {
    var currentIem: VideoShortModel?

    override init() {
        super.init()
        self.inset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }
    
    override func didUpdate(to object: Any) {
        guard let superHero = object as? VideoShortModel else {
            return
        }
        currentIem = superHero
    }
    
    override func numberOfItems() -> Int {
        return 1
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        var cell: UICollectionViewCell = UICollectionViewCell()
        
//        if let sectionType = currentIem?.homeSectionType {
//            if sectionType == "BANNER" {
//                cell = getDataForCell(with: BannerCell.self, at: index) ?? UICollectionViewCell()
//            } else {
//                cell = getDataForCell(with: CategoryCell.self, at: index) ?? UICollectionViewCell()
//            }
//        }
//
//        if let ad = currentIem {
//            (cell as? UpdateBannerCellProtocol)?.update(with: ad.recommendContentVOList, homeController: self.controller!)
//        }
//
        return cell
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        let collectionViewWidth = ((collectionContext?.containerSize.width)! - 10)
        let collectionViewHeight = collectionContext?.containerSize.height ?? 0        
        return CGSize(width: collectionViewWidth, height: collectionViewHeight)
    }
    
    override func didSelectItem(at index: Int) {
        dLogDebug(index)
    }
}
