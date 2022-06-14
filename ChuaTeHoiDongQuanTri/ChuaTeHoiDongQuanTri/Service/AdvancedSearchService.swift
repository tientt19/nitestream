//
//  AdvancedSearchService.swift
//  ChuTeHoiDongQuanTri
//
//  Created by Valerian on 11/06/2022.
//

import Foundation

protocol AdvancedSearchServiceProtocols: AnyObject {
    func onGetListSearch(completion: @escaping ((Result<BaseModel<[SearchListModel]>, APIError>) -> Void))
    func onGetSearchResult(with params: String,completion: @escaping ((Result<BaseModel<SearchResultModel>, APIError>) -> Void))
    func onGetSearchResultWithParams(with params: [String:Any], completion: @escaping ((Result<BaseModel<SearchResultModel>, APIError>) -> Void))
}

class AdvancedSearchService: AdvancedSearchServiceProtocols {
    private let service = BaseService.shared

    func onGetListSearch(completion: @escaping ((Result<BaseModel<[SearchListModel]>, APIError>) -> Void)) {
        let urlString = URLTypes.listAdvancedSearch.path
        self.service.GET(url: urlString,
                         param: nil,
                         completion: completion)
    }
    
    func onGetSearchResult(with params: String, completion: @escaping ((Result<BaseModel<SearchResultModel>, APIError>) -> Void)) {
        let urlString = URLTypes.listAdvancedSearchResult.path
        let paramsBody: [String : Any] = [ "size": 180,
                                           "sort": "1654840857389,20372",
                                           "params": params,
                                           "area": "",
                                           "category": "",
                                           "year": "",
                                           "subtitles": "",
                                           "order": "up" ]
        self.service.POST(url: urlString,
                          param: paramsBody,
                          completion: completion)
    }
    
    func onGetSearchResultWithParams(with params: [String : Any], completion: @escaping ((Result<BaseModel<SearchResultModel>, APIError>) -> Void)) {
        let urlString = URLTypes.listAdvancedSearchResult.path
        self.service.POST(url: urlString,
                          param: params,
                          completion: completion)
    }
    
}
