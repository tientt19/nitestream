//
//  StreamingListCollectionSectionController.swift
//  ChuTeHoiDongQuanTri
//
//  Created by Valerian on 12/05/2022.
//

import Foundation
import IGListKit

protocol onSelectAnotherMediaProtocol: AnyObject {
    func onDidSelect(with dataItem: DataModel)
}

class StreamingListCollectionSectionController: ListSectionController {
    var currentIem: Section?
    var onHandleDelegate: onSelectAnotherMediaProtocol?
    
    override init() {
        super.init()
        self.minimumLineSpacing = 5
        self.supplementaryViewSource = self
        self.inset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }
    
    override func didUpdate(to object: Any) {
        guard let superHero = object as? Section else {
            return
        }
        currentIem = superHero
    }
    
    override func numberOfItems() -> Int {
        return currentIem?.data.count ?? 0
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        let nibName = String(describing: TopSearchCell.self)
        let cell = collectionContext?.dequeueReusableCell(withNibName: nibName, bundle: nil, for: self, at: index) as! TopSearchCell
        if let data = self.currentIem?.data[index] {
            let imageurl = data.coverHorizontalUrl ?? ""
            let name = data.name ?? ""
            cell.configure(imageurl,name)
        }
        return cell
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        let collectionViewWidth = collectionContext?.containerSize.width ?? 0
        return CGSize(width: collectionViewWidth - 10, height: 80)
    }
    
    override func didSelectItem(at index: Int) {
        self.onHandleDelegate?.onDidSelect(with: (self.currentIem?.data[index])!)
    }
}

//MARK: - ListSupplementaryViewSource -- HEADER
extension StreamingListCollectionSectionController: ListSupplementaryViewSource {
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
        return CGSize(width: collectionContext!.containerSize.width, height: 30)
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
        
        var sectionName = String()
        
        if currentIem?.title == FooterDetailSectionTypes.refList.rawValue {
            sectionName = FooterDetailSectionTypes.refList.rawValue
        } else {
            sectionName = FooterDetailSectionTypes.likeList.rawValue
        }
        
        headerView.configure(sectionName)
        headerView.mainTitle.textColor = .white
        headerView.expandButton.isHidden = true
        return headerView
    }
}

