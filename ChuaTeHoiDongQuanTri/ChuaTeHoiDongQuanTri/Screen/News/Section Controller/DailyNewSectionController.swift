//
//  DailyNewSectionController.swift
//  ChuTeHoiDongQuanTri
//
//  Created by Valerian on 04/06/2022.
//

import Foundation
import IGListKit

class DailyNewsSectionController: ListSectionController {
    var currentIem: DailyNewsModel?
    
    override init() {
        super.init()
        self.minimumLineSpacing = 10
        self.inset = UIEdgeInsets(top: 10, left: 16, bottom: 10, right: 16)
    }
    
    override func didUpdate(to object: Any) {
        guard let superHero = object as? DailyNewsModel else {
            return
        }
        currentIem = superHero
    }
    
    override func numberOfItems() -> Int {
        return self.currentIem?.list?.count ?? 0
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        let nibName = String(describing: CellCollectionViewDailyNews.self)
        let cell = collectionContext?.dequeueReusableCell(withNibName: nibName, bundle: nil, for: self, at: index) as! CellCollectionViewDailyNews
        cell.model = self.currentIem?.list?[index]
        return cell
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        let collectionViewWidth = ((collectionContext?.containerSize.width)! - 32)
        let collectionViewHeight = ((collectionContext?.containerSize.height)! - 20) / 1.5
        return CGSize(width: collectionViewWidth, height: collectionViewHeight)
    }
    
    override func didSelectItem(at index: Int) {
        dLogDebug(index)
    }
    
}
