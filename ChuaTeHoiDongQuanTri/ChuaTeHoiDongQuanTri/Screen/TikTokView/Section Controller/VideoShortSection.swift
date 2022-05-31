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
    var mediaIsPlaying = false

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
        let nibName = String(describing: ShortVideoCollectionCell.self)
        let cell = collectionContext?.dequeueReusableCell(withNibName: nibName, bundle: nil, for: self, at: index) as! ShortVideoCollectionCell
        if self.mediaIsPlaying == false {
            self.mediaIsPlaying.toggle()
            cell.configure(link: (self.currentIem?.videoShortData?.mediaUrl)!, data: (self.currentIem?.reviewData)!)
        }
        return cell
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        let collectionViewWidth = ((collectionContext?.containerSize.width)! - 10)
        let collectionViewHeight = ((collectionContext?.containerSize.height)! - 10)
        return CGSize(width: collectionViewWidth, height: collectionViewHeight)
    }
    
    override func didSelectItem(at index: Int) {
        dLogDebug(index)
    }
}
