//
//  AdvancedSearchService.swift
//  ChuTeHoiDongQuanTri
//
//  Created by Valerian on 11/06/2022.
//

import Foundation


protocol AdvancedSearchServiceProtocols: AnyObject {
    func onGetListSearch(completion: @escaping ((Result<BaseModel<[SearchListModel]>, APIError>) -> Void))
}

class AdvancedSearchService: AdvancedSearchServiceProtocols {
    private let service = BaseService.shared

    func onGetListSearch(completion: @escaping ((Result<BaseModel<[SearchListModel]>, APIError>) -> Void)) {
        let urlString = URLTypes.listAdvancedSearch.path
        self.service.GET(url: urlString,
                         param: nil,
                         completion: completion)
    }
}
