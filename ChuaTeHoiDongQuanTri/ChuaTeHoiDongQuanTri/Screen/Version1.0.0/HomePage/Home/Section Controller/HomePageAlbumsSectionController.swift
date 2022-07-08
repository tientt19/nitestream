//
//  HomePageAlbumsSectionControler.swift
//  ChuTeHoiDongQuanTri
//
//  Created by Valerian on 04/06/2022.
//

import Foundation
import IGListKit

class HomePageAlbumsSectionController: ListSectionController {
    var currentIem: HomePageModels?
    var controller: HomePageViewViewController?
    
    override init() {
        super.init()
        minimumLineSpacing = 10
        self.inset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }
    
    override func didUpdate(to object: Any) {
        guard let superHero = object as? HomePageModels else {
            return
        }
        currentIem = superHero
    }
    
    override func numberOfItems() -> Int {
        return self.currentIem?.recommendItems?.count ?? 0
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        let nibName = String(describing: CategoryCell.self)
        let cell = collectionContext?.dequeueReusableCell(withNibName: nibName, bundle: nil, for: self, at: index) as! CategoryCell
        if let model = self.currentIem?.recommendItems {
            cell.lbl_header.text = model[index].homeSectionName
            cell.sendDelegate = self.controller
            cell.model = self.currentIem?.recommendItems?[index]
            cell.configure(data: model[index].recommendContentVOList!)
        }
        return cell
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        let collectionViewWidth = ((collectionContext?.containerSize.width)! - 10)
        let collectionViewHeight = ((collectionViewWidth * 9) / 16) +
        estimateFrameForText(text: (self.currentIem?.recommendItems?[index].homeSectionName)!, width: collectionViewWidth - 90).height
        return CGSize(width: collectionViewWidth, height: collectionViewHeight + 15)
    }
    
    override func didSelectItem(at index: Int) {
        dLogDebug(index)
    }
}

extension HomePageAlbumsSectionController {
    private func estimateFrameForText(text: String, width: CGFloat) -> CGRect {
        let height: CGFloat = 999
        let size = CGSize(width: width, height: height)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 22, weight: UIFont.Weight.bold)]
        return NSString(string: text).boundingRect(with: size, options: options, attributes: attributes, context: nil)
    }
}
