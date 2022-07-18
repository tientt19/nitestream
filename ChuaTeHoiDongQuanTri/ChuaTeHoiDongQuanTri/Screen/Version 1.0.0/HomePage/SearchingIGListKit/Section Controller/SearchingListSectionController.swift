//
//  SearchingListSectionController.swift
//  ChuTeHoiDongQuanTri
//
//  Created by Valerian on 06/05/2022.
//

import Foundation
import IGListKit

class SearchingListSectionController: ListSectionController {
    var currentIem: SearchingModelIG?
    var handleTapDelegate: onTapDetailProtocol?
    
    override init() {
        super.init()
        self.inset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: -5)
    }
    
    override func didUpdate(to object: Any) {
        guard let superHero = object as? SearchingModelIG else {
            return
        }
        currentIem = superHero
    }
    
    override func numberOfItems() -> Int {
        return 1
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        var cell: UICollectionViewCell = UICollectionViewCell()
        if let movieCell = getData(at: index) {
            cell = movieCell
        }
        
        if let ad = currentIem {
            (cell as? CellSeachingCollectionView)?.update(with: ad.content.htmlToString)
        }
        
        return cell
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        let collectionViewWidth = collectionContext?.containerSize.width ?? 0
        return CGSize(width: collectionViewWidth, height: 40)
    }
    
    override func didSelectItem(at index: Int) {
        self.handleTapDelegate?.didSelect(with: currentIem?.content ?? "")
    }
}

extension SearchingListSectionController {
    private func getData(at index: Int) -> UICollectionViewCell? {
        guard let ctx = collectionContext else {
            return UICollectionViewCell()
        }
        let nibName = String(describing: CellSeachingCollectionView.self)
        let cell = ctx.dequeueReusableCell(withNibName: nibName , bundle: nil, for: self, at: index)
        return cell
    }
}
