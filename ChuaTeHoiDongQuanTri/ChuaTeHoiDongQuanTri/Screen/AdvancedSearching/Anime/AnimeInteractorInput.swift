//
//  
//  AnimeInteractorInput.swift
//  ChuTeHoiDongQuanTri
//
//  Created by Valerian on 11/06/2022.
//
//

import UIKit

// MARK: - Interactor Input Protocol
protocol AnimeInteractorInputProtocol {
    func onGetListSearch()
    func onGetSearhResult(with params: String)
    func onGetSearchResultWithParams(with params: [String:Any])
}

// MARK: - Interactor Output Protocol
protocol AnimeInteractorOutputProtocol: AnyObject {
    func didGetListSearchFinished(with result: Result<[SearchListModel], APIError>)
    func didGetSearchResultFinished(with result: Result<SearchResultModel, APIError>)
}

// MARK: - Anime InteractorInput
class AnimeInteractorInput {
    weak var output: AnimeInteractorOutputProtocol?
    let service = AdvancedSearchService()
}

// MARK: - Anime InteractorInputProtocol
extension AnimeInteractorInput: AnimeInteractorInputProtocol {
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
}
