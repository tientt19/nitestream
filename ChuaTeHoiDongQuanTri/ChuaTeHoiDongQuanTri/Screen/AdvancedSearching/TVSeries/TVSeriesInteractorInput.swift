//
//  
//  TVSeriesInteractorInput.swift
//  ChuTeHoiDongQuanTri
//
//  Created by Valerian on 11/06/2022.
//
//

import UIKit

// MARK: - Interactor Input Protocol
protocol TVSeriesInteractorInputProtocol {
    func onGetListSearch()
    func onGetSearhResult(with params: String)
}

// MARK: - Interactor Output Protocol
protocol TVSeriesInteractorOutputProtocol: AnyObject {
    func didGetListSearchFinished(with result: Result<[SearchListModel], APIError>)
    func didGetSearchResultFinished(with result: Result<SearchResultModel, APIError>)
}

// MARK: - TVSeries InteractorInput
class TVSeriesInteractorInput {
    weak var output: TVSeriesInteractorOutputProtocol?
    let service = AdvancedSearchService()
}

// MARK: - TVSeries InteractorInputProtocol
extension TVSeriesInteractorInput: TVSeriesInteractorInputProtocol {
    func onGetListSearch() {
        self.service.onGetListSearch { [weak self] result in
            self?.output?.didGetListSearchFinished(with: result.unwrapSuccessModel())
        }
    }
    
    
    func onGetSearhResult(with params: String) {
        self.service.onGetSearchResult(with: params) { [weak self] result in
            dLogDebug(result)
            self?.output?.didGetSearchResultFinished(with: result.unwrapSuccessModel())
        }
    }

}
