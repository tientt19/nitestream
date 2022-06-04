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
    
    override init() {
        super.init()
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
            cell.configure(data: model[index].recommendContentVOList!)
        }
        return cell
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        let collectionViewWidth = ((collectionContext?.containerSize.width)! - 10)
        let collectionViewHeight = (collectionViewWidth * 9) / 16
        return CGSize(width: collectionViewWidth, height: collectionViewHeight + 30)
    }
    
    override func didSelectItem(at index: Int) {
        dLogDebug(index)
    }
}

////MARK: - ListSupplementaryViewSource -- HEADER
//extension HomePageAlbumsSectionController: ListSupplementaryViewSource {
//    func supportedElementKinds() -> [String] {
//        return [UICollectionView.elementKindSectionHeader]
//    }
//
//    func viewForSupplementaryElement(ofKind elementKind: String, at index: Int) -> UICollectionReusableView {
//        switch elementKind {
//        case UICollectionView.elementKindSectionHeader:
//            return headerView(atIndex: index)
//        default:
//            fatalError()
//        }
//    }
//
//    func sizeForSupplementaryView(ofKind elementKind: String, at index: Int) -> CGSize {
//        return CGSize(width: collectionContext!.containerSize.width, height: 30)
//    }
//
//    // MARK: Private
//    private func headerView(atIndex index: Int) -> UICollectionReusableView {
//        let nibName = String(describing: MainHeader.self)
//
//        let headerView: MainHeader = collectionContext?.dequeueReusableSupplementaryView(
//            ofKind: UICollectionView.elementKindSectionHeader,
//            for: self,
//            nibName: nibName,
//            bundle: nil,
//            at: index) as! MainHeader
//
//        let sectionName = currentIem?.recommendItems?[index].homeSectionName
//
////        headerView.tapDelegate = self
//        headerView.configure(sectionName ?? "")
//        headerView.expandButton.isHidden = false
//        return headerView
//    }
//}

////MARK: - HandleTapHeaderProtocol
//extension HomePageAlbumsSectionController: HandleTapHeaderProtocol {
//    func tap() {
//        if currentIem?.homeSectionType != "BLOCK_GROUP" {
//            self.openExpandViewDelegate?.onOpenExpand(with: currentIem!)
//        }
//    }
//}
