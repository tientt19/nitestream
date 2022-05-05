//
//  ExpandSectionController.swift
//  ChuTeHoiDongQuanTri
//
//  Created by Valerian on 04/05/2022.
//

import Foundation
import IGListKit

protocol HandleTapProtocol: AnyObject {
    func didSelect(with index: Int)
}

class ExpandSectionController: ListSectionController {
    var currentIem: RecommendItem?
    var handleTapDelegate: HandleTapProtocol?
    
    override init() {
        super.init()
        self.inset = UIEdgeInsets(top: 5, left: 5, bottom: 0, right: 5)
    }
    
    override func didUpdate(to object: Any) {
        guard let superHero = object as? RecommendItem else {
            return
        }
        currentIem = superHero
    }
    
    override func numberOfItems() -> Int {
        return currentIem?.recommendContentVOList.count ?? 0
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        var cell: UICollectionViewCell = UICollectionViewCell()
        guard let item = currentIem else {
            return cell
        }
        
        if let movieCell = getData(at: index) {
            cell = movieCell
        }
        
        guard let superHeroCell = cell as? ExpandModelUpdatable else {
            return cell
        }
        
        superHeroCell.updateWith(item.recommendContentVOList[index].imageUrl, item.recommendContentVOList[index].title)
        
        return cell
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        let collectionViewWidth = collectionContext?.containerSize.width ?? 0
        let itemWidth = ((collectionViewWidth - 20) / 3)
        let heigher = itemWidth * 7 / 5
        return CGSize(width: itemWidth , height: heigher + 30)
    }
    
    override func didSelectItem(at index: Int) {
        handleTapDelegate?.didSelect(with: index)
    }
}

extension ExpandSectionController {
    private func getData(at index: Int) -> UICollectionViewCell? {
        guard let ctx = collectionContext else {
            return UICollectionViewCell()
        }
        let nibName = String(describing: MovieCell.self)
        let cell = ctx.dequeueReusableCell(withNibName: nibName , bundle: nil, for: self, at: index)
        return cell
    }
}
