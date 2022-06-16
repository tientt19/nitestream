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
    func onGetSearchResultWithParams(with params: [String:Any])
    func onGetMovieDetail(with model: SearchResults)
}

// MARK: - Interactor Output Protocol
protocol TVSeriesInteractorOutputProtocol: AnyObject {
    func didGetListSearchFinished(with result: Result<[SearchListModel], APIError>)
    func didGetSearchResultFinished(with result: Result<SearchResultModel, APIError>)
    func didGetAlbumsDetailFinish(with result: MovieDetail)
}

// MARK: - TVSeries InteractorInput
class TVSeriesInteractorInput {
    weak var output: TVSeriesInteractorOutputProtocol?
    let service = AdvancedSearchService()
    let homePageService = HomePageService()
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
            self?.output?.didGetSearchResultFinished(with: result.unwrapSuccessModel())
        }
    }
    
    func onGetSearchResultWithParams(with params: [String : Any]) {
        self.service.onGetSearchResultWithParams(with: params) { [weak self] result in
            self?.output?.didGetSearchResultFinished(with: result.unwrapSuccessModel())
        }
    }
    
    func onGetMovieDetail(with model: SearchResults) {
        let idInt = Int(model.id ?? "0")
        DataManager.shared.getDetailMovieData(idInt ?? 0, model.domainType ?? -1) { [weak self] response in
            guard let `self` = self else { return }
            if let data = response {
                self.output?.didGetAlbumsDetailFinish(with: data)
            }
        }
    }
}
