//
//  SearchingIGListKitSectionController.swift
//  ChuTeHoiDongQuanTri
//
//  Created by Valerian on 05/05/2022.
//

import Foundation
import IGListKit

protocol onTapDetailProtocol: AnyObject {
    func didSelect(with data: TopSearchData)
}

class SearchingIGListKitSectionController: ListSectionController {
    var currentIem: TopSearchData?
    var handleTapDelegate: onTapDetailProtocol?
    
    override init() {
        super.init()
        self.inset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: -5)
    }
    
    override func didUpdate(to object: Any) {
        guard let superHero = object as? TopSearchData else {
            return
        }
        currentIem = superHero
    }
    
    override func numberOfItems() -> Int {
        return 1
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        var cell: UICollectionViewCell = UICollectionViewCell()
        guard let item = currentIem else {
            return cell
        }
        
        if let movieCell = getData(at: index) {
            cell = movieCell
        }
        
        guard let superHeroCell = cell as? ConfigureDataPrototcol else {
            return cell
        }
        
        superHeroCell.update(item.cover, item.title)
        
        return cell
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        let collectionViewWidth = collectionContext?.containerSize.width ?? 0
        return CGSize(width: collectionViewWidth , height: 80)
    }
    
    override func didSelectItem(at index: Int) {
        handleTapDelegate?.didSelect(with: self.currentIem!)
    }
}

extension SearchingIGListKitSectionController {
    private func getData(at index: Int) -> UICollectionViewCell? {
        guard let ctx = collectionContext else {
            return UICollectionViewCell()
        }
        let nibName = String(describing: SearchingIGListKitCell.self)
        let cell = ctx.dequeueReusableCell(withNibName: nibName , bundle: nil, for: self, at: index)
        return cell
    }
}
