//
//  
//  MoviesViewModel.swift
//  ChuTeHoiDongQuanTri
//
//  Created by Valerian on 11/06/2022.
//
//

import UIKit

// MARK: - ViewModelProtocol
protocol MoviesViewModelProtocol {
    func onViewDidLoad()
    func onGetSearchResult(with params: String)
    func onGetSearchResultWithParams(with params: [String:Any])
}

// MARK: - Movies ViewModel
class MoviesViewModel {
    weak var view: MoviesViewProtocol?
    private var interactor: MoviesInteractorInputProtocol

    init(interactor: MoviesInteractorInputProtocol) {
        self.interactor = interactor
    }

}

// MARK: - Movies ViewModelProtocol
extension MoviesViewModel: MoviesViewModelProtocol {
    func onViewDidLoad() {
        self.interactor.onGetListSearch()
    }
    
    func onGetSearchResult(with params: String) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.interactor.onGetSearhResult(with: params)
        }
    }
    
    func onGetSearchResultWithParams(with params: [String : Any]) {
        self.interactor.onGetSearchResultWithParams(with: params)
    }
}

// MARK: - Movies InteractorOutputProtocol
extension MoviesViewModel: MoviesInteractorOutputProtocol {
    func didGetListSearchFinished(with result: Result<[SearchListModel], APIError>) {
        switch result {
        case .success(let model):
            self.view?.didGetSearchListFinished(with: model)
        case .failure(let error):
            dLogDebug(error.message)
        }
    }
    
    func didGetSearchResultFinished(with result: Result<SearchResultModel, APIError>) {
        switch result {
        case .success(let model):
            self.view?.didGetAdvancedSearchResult(with: model)
        case .failure(let error):
            dLogDebug(error.message)
        }
    }
}
