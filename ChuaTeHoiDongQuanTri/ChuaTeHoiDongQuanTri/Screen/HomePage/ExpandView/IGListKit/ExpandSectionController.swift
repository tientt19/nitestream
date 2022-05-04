//
//  ExpandSectionController.swift
//  ChuTeHoiDongQuanTri
//
//  Created by Valerian on 04/05/2022.
//

import Foundation
import IGListKit

class ExpandSectionController: ListSectionController {
    var currentIem: RecommendContentVOList?
    
    override init() {
        super.init()
        self.inset = UIEdgeInsets(top: 0, left: 0, bottom: 5, right: 5)
    }
    
    override func didUpdate(to object: Any) {
        guard let superHero = object as? RecommendContentVOList else {
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
        
        guard let superHeroCell = cell as? ExpandModelUpdatable else {
            return cell
        }
        
        superHeroCell.updateWith(item.imageUrl, item.title)
        
        return cell
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        let widther = (collectionContext?.containerSize.width)! / 3
        let heigher = widther * 7 / 5
        return CGSize(width: widther - 10, height: heigher + 30)
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
