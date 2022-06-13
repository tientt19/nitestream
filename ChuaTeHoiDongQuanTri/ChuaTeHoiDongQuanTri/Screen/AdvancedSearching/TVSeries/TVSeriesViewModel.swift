//
//  
//  TVSeriesViewModel.swift
//  ChuTeHoiDongQuanTri
//
//  Created by Valerian on 11/06/2022.
//
//

import UIKit

// MARK: - ViewModelProtocol
protocol TVSeriesViewModelProtocol {
    func onViewDidLoad()
    func onGetSearchResult(with params: String)
}

// MARK: - TVSeries ViewModel
class TVSeriesViewModel {
    weak var view: TVSeriesViewProtocol?
    private var interactor: TVSeriesInteractorInputProtocol

    init(interactor: TVSeriesInteractorInputProtocol) {
        self.interactor = interactor
    }

}

// MARK: - TVSeries ViewModelProtocol
extension TVSeriesViewModel: TVSeriesViewModelProtocol {
    func onViewDidLoad() {
        self.interactor.onGetListSearch()
    }
    
    func onGetSearchResult(with params: String) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.interactor.onGetSearhResult(with: params)
        }
    }
}

// MARK: - TVSeries InteractorOutputProtocol
extension TVSeriesViewModel: TVSeriesInteractorOutputProtocol {
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
