//
//  AnimeResultSectionController.swift
//  nitestream
//
//  Created by Valerian on 16/06/2022.
//

import Foundation
import IGListKit

class AnimeResultSectionController: ListSectionController {
    var currentIem: SearchResultModel?
    var delegate: onOpenMovieDetailProtocols?
    
    override init() {
        super.init()
        minimumLineSpacing = 5
        self.inset = UIEdgeInsets(top: 0, left: 5, bottom: 5, right: 5)
    }
    
    override func didUpdate(to object: Any) {
        guard let superHero = object as? SearchResultModel else {
            return
        }
        currentIem = superHero
    }
    
    override func numberOfItems() -> Int {
        return self.currentIem?.searchResults?.count ?? 0
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        let nibName = String(describing: CellCollectionViewAdvancedSearch.self)
        let cell = collectionContext?.dequeueReusableCell(withNibName: nibName, bundle: nil, for: self, at: index) as! CellCollectionViewAdvancedSearch
        cell.model = self.currentIem?.searchResults?[index]
        return cell
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        let collectionViewWidth = ((collectionContext?.containerSize.width)! - 20) / 3
        let collectionViewHeight = collectionViewWidth * 7 / 5
        return CGSize(width: collectionViewWidth, height: collectionViewHeight)
    }
    
    override func didSelectItem(at index: Int) {
        self.delegate?.onOpenMovieDetail(with: (self.currentIem?.searchResults?[index])!)
    }
}
