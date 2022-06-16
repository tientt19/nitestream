//
//  TVSeriesSectionController.swift
//  ChuTeHoiDongQuanTri
//
//  Created by Valerian on 11/06/2022.
//

import Foundation
import IGListKit

protocol onGetAdvancedSearching: AnyObject {
    func onGetSearchResultWithParams(with params: [String:Any])
}

class SearchListSectionController: ListSectionController{
    var currentIem: ScreeningItem?
    var delegate: onGetAdvancedSearching?
        
    override init() {
        super.init()
        self.inset = UIEdgeInsets(top: 0, left: 5, bottom: 5, right: 5)
    }
    
    override func didUpdate(to object: Any) {
        guard let superHero = object as? ScreeningItem else {
            return
        }
        superHero.items?[0].isSelected = true
        currentIem = superHero
    }
    
    override func numberOfItems() -> Int {
        return 1
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        let nibName = String(describing: CellCollectionViewSearchParams.self)
        let cell = collectionContext?.dequeueReusableCell(withNibName: nibName, bundle: nil, for: self, at: index) as! CellCollectionViewSearchParams
        cell.delegate = self
        cell.model = self.currentIem
        return cell
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        let collectionViewWidth = ((collectionContext?.containerSize.width)! - 10)
        return CGSize(width: collectionViewWidth, height: 43)
    }
    
    override func didSelectItem(at index: Int) {
//        dLogDebug(self.currentIem?.name)
    }
}

//MARK: - onSendParmasToSearchProtocols
extension SearchListSectionController: onSendParmasToSearchProtocols {
    func onSendParams(with params: [String : Any]?) {
        self.delegate?.onGetSearchResultWithParams(with: params!)
    }
}
