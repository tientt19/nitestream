//
//  BannerSectionController.swift
//  ChuTeHoiDongQuanTri
//
//  Created by Valerian on 09/05/2022.
//

import Foundation
import IGListKit

protocol HandleExpandViewOpenProtocols: AnyObject {
    func onOpenExpand(with data: RecommendItem)
}

class BannerSectionController: ListSectionController {
    var currentIem: RecommendItem?
    var controller: HomePageViewViewController?
    var openExpandViewDelegate: HandleExpandViewOpenProtocols?

    override init() {
        super.init()
        supplementaryViewSource = self
        self.inset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }
    
    override func didUpdate(to object: Any) {
        guard let superHero = object as? RecommendItem else {
            return
        }
        currentIem = superHero
    }
    
    override func numberOfItems() -> Int {
        return 1
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        var cell: UICollectionViewCell = UICollectionViewCell()
        
        if let sectionType = currentIem?.homeSectionType {
            if sectionType == "BANNER" {
                cell = getDataForCell(with: BannerCell.self, at: index) ?? UICollectionViewCell()
            } else {
                cell = getDataForCell(with: CategoryCell.self, at: index) ?? UICollectionViewCell()
            }
        }
                
        if let ad = currentIem {
            (cell as? UpdateBannerCellProtocol)?.update(with: ad.recommendContentVOList, homeController: self.controller!)
        }
        
        return cell
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        let collectionViewWidth = ((collectionContext?.containerSize.width)! - 10)
        let collectionViewHeight = (collectionViewWidth * 9) / 16
        return CGSize(width: collectionViewWidth, height: collectionViewHeight)
    }
    
    override func didSelectItem(at index: Int) {
        dLogDebug(index)
    }
}

//MARK: - Dequeue Cell
extension BannerSectionController {
    private func getDataForCell(with typeCell: UICollectionViewCell.Type, at index: Int) -> UICollectionViewCell? {
        guard let ctx = collectionContext else {
            return UICollectionViewCell()
        }
        
        let nibName = String(describing: typeCell.self)
        
        let cell = ctx.dequeueReusableCell(withNibName: nibName, bundle: nil, for: self, at: index)
        return cell
    }
}

//MARK: - ListSupplementaryViewSource -- HEADER
extension BannerSectionController: ListSupplementaryViewSource {
    func supportedElementKinds() -> [String] {
        return [UICollectionView.elementKindSectionHeader]
    }
    
    func viewForSupplementaryElement(ofKind elementKind: String, at index: Int) -> UICollectionReusableView {
        switch elementKind {
        case UICollectionView.elementKindSectionHeader:
            return headerView(atIndex: index)
        default:
            fatalError()
        }
    }
    
    func sizeForSupplementaryView(ofKind elementKind: String, at index: Int) -> CGSize {
        if currentIem?.homeSectionType == "BANNER" {
            return CGSize(width: collectionContext!.containerSize.width, height: 0)
        }else {
            return CGSize(width: collectionContext!.containerSize.width, height: 30)
        }
    }
    
    // MARK: Private
    private func headerView(atIndex index: Int) -> UICollectionReusableView {
        let nibName = String(describing: MainHeader.self)

        let headerView: MainHeader = collectionContext?.dequeueReusableSupplementaryView(
            ofKind: UICollectionView.elementKindSectionHeader,
            for: self,
            nibName: nibName,
            bundle: nil,
            at: index) as! MainHeader
        
        let sectionName = currentIem?.homeSectionName
        let sectionType = currentIem?.homeSectionType
        
        headerView.tapDelegate = self
        headerView.configure(sectionName ?? "")
        if sectionType == "BLOCK_GROUP" {
            headerView.disableExpandButton()
        } else {
            headerView.expandButton.isHidden = false
        }
        return headerView
    }
}

//MARK: - HandleTapHeaderProtocol
extension BannerSectionController: HandleTapHeaderProtocol {
    func tap() {
        if currentIem?.homeSectionType != "BLOCK_GROUP" {
            self.openExpandViewDelegate?.onOpenExpand(with: currentIem!)
        }
    }
}
