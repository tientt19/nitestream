//
//  EpisodeSectionController.swift
//  ChuTeHoiDongQuanTri
//
//  Created by Valerian on 13/05/2022.
//

import Foundation
import IGListKit

protocol onSelectEpisodeProtocols: AnyObject {
    func didSelect(with data: EpisodeVo?)
}

class StreamingEpisodeSectionController: ListSectionController {
    var currentIem: EpisodeCollection?
    var onHandleDelegate: onSelectEpisodeProtocols?
    
    override init() {
        super.init()
        self.supplementaryViewSource = self
        self.minimumLineSpacing = 5
        self.minimumInteritemSpacing = 2.5
        self.inset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }
    
    override func didUpdate(to object: Any) {
        guard let superHero = object as? EpisodeCollection else {
            return
        }
        self.currentIem = superHero
    }
    
    override func numberOfItems() -> Int {
        if (self.currentIem?.listEpisode.count)! > 1 {
            return self.currentIem?.listEpisode.count ?? 0
        } else {
            return 0
        }
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        let nibName = String(describing: ListInfoCell.self)
        let cell = collectionContext?.dequeueReusableCell(withNibName: nibName, bundle: nil, for: self, at: index) as! ListInfoCell
        if let data = self.currentIem?.listEpisode[index] {
            cell.configure(data)
        }
        return cell
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        if self.currentIem?.listEpisode.count == 0 {
            return CGSize(width: 0, height: 0)
        }
        return CGSize(width: 50, height: 50)
    }
    
    override func didSelectItem(at index: Int) {
        self.onHandleDelegate?.didSelect(with: self.currentIem?.listEpisode[index])
    }
}

//MARK: - ListSupplementaryViewSource -- HEADER
extension StreamingEpisodeSectionController: ListSupplementaryViewSource {
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
        if (self.currentIem?.listEpisode.count)! > 1 {
            return CGSize(width: collectionContext!.containerSize.width, height: 30)
        } else {
            return CGSize(width: collectionContext!.containerSize.width, height: 0)
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
        
        let sectionName = FooterDetailSectionTypes.eps.rawValue
        
        headerView.configure(sectionName)
        headerView.mainTitle.textColor = .white
        headerView.expandButton.isHidden = true
        return headerView
    }
}
