//
//  StreamingInfoSectionController.swift
//  ChuTeHoiDongQuanTri
//
//  Created by Valerian on 11/05/2022.
//

import Foundation
import IGListKit

class StreamingInfoSectionController: ListSectionController {
    
    private var expanded = false
    var currentIem: MovieInfo?
    var subRemoteURL: String?

    override init() {
        super.init()
        self.inset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    override func didUpdate(to object: Any) {
        guard let superHero = object as? MovieInfo else {
            return
        }
        currentIem = superHero
    }
    
    override func numberOfItems() -> Int {
        return 2
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        if index == 0 {
            let nibName = String(describing: CellCollectionMovieInfo.self)
            let cell = collectionContext?.dequeueReusableCell(withNibName: nibName, bundle: nil, for: self, at: index) as! CellCollectionMovieInfo
            cell.configure(data: self.currentIem!)
            cell.hideIntroduction()
            return cell
        } else {
            let cell: LabelCell = collectionContext?.dequeueReusableCell(of: LabelCell.self, for: self, at: index) as! LabelCell
            cell.text = currentIem?.introduction
            return cell
        }
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        let collectionViewWidth = collectionContext?.containerSize.width ?? 0
        if index == 0 {
            return CGSize(width: collectionViewWidth, height: 50)
        } else {
            let height = expanded ? LabelCell.textHeight(currentIem?.introduction ?? "", width: collectionViewWidth) : 150
            return CGSize(width: collectionViewWidth, height: height)
        }
    }
    
    override func didSelectItem(at index: Int) {
        didDeselectItem(at: index)
        if index == 1 {
            self.expanded = !self.expanded
            UIView.animate(withDuration: 0.5,
                           delay: 0,
                           usingSpringWithDamping: 0.4,
                           initialSpringVelocity: 0.6,
                           options: [],
                           animations: {
                self.collectionContext?.invalidateLayout(for: self)
            })
        }
    }
}
