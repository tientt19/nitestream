//
//  ExpandDataSource.swift
//  ChuTeHoiDongQuanTri
//
//  Created by Valerian on 04/05/2022.
//

import IGListKit

class ExpandDataSource: NSObject, ListAdapterDataSource {
    
    var data : RecommendItem?
    
    init(data : RecommendItem) {
        self.data = data
    }
    
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return (data?.recommendContentVOList as? [ListDiffable])!
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        return ExpandSectionController()
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }
}

