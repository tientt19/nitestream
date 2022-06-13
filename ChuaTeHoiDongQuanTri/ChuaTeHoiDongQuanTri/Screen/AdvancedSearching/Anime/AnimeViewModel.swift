//
//  
//  AnimeViewModel.swift
//  ChuTeHoiDongQuanTri
//
//  Created by Valerian on 11/06/2022.
//
//

import UIKit

// MARK: - ViewModelProtocol
protocol AnimeViewModelProtocol {
    func onViewDidLoad()
    func onGetSearchResult(with params: String)
}

// MARK: - Anime ViewModel
class AnimeViewModel {
    weak var view: AnimeViewProtocol?
    private var interactor: AnimeInteractorInputProtocol

    init(interactor: AnimeInteractorInputProtocol) {
        self.interactor = interactor
    }

}

// MARK: - Anime ViewModelProtocol
extension AnimeViewModel: AnimeViewModelProtocol {
    func onViewDidLoad() {
        self.interactor.onGetListSearch()
    }
    
    func onGetSearchResult(with params: String) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.interactor.onGetSearhResult(with: params)
        }
    }
}

// MARK: - Anime InteractorOutputProtocol
extension AnimeViewModel: AnimeInteractorOutputProtocol {
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
