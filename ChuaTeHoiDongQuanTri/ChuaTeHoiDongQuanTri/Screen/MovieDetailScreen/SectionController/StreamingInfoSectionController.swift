//
//  StreamingInfoSectionController.swift
//  ChuTeHoiDongQuanTri
//
//  Created by Valerian on 11/05/2022.
//

import Foundation
import IGListKit

class StreamingInfoSectionController: ListSectionController {
    var currentIem: MovieInfo?
    var subRemoteURL: String?

    override init() {
        super.init()
        self.inset = UIEdgeInsets(top: 0, left: 0, bottom: 5, right: 0)
    }
    
    override func didUpdate(to object: Any) {
        guard let superHero = object as? MovieInfo else {
            return
        }
        currentIem = superHero
    }
    
    override func numberOfItems() -> Int {
        return 1
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        let nibName = String(describing: CellCollectionMovieInfo.self)
        let cell = collectionContext?.dequeueReusableCell(withNibName: nibName, bundle: nil, for: self, at: index) as! CellCollectionMovieInfo
        cell.configure(data: self.currentIem!)
        return cell
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        let collectionViewWidth = collectionContext?.containerSize.width ?? 0
        return CGSize(width: collectionViewWidth, height: 500)
    }
    
    override func didSelectItem(at index: Int) {
        dLogDebug(index)
    }
}
