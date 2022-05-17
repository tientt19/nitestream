//
//  
//  SearchingIGListKitScreenViewModel.swift
//  ChuTeHoiDongQuanTri
//
//  Created by Valerian on 05/05/2022.
//
//

import UIKit

// MARK: - ViewModelProtocol
protocol SearchingIGListKitScreenViewModelProtocol {
    func onViewDidLoad()
    func openDetailView(id: String, category: Int)
    func onSearchWithKeyWork(with key: String)
    func ongetListSearch(with keyword: String)
}

// MARK: - SearchingIGListKitScreen ViewModel
class SearchingIGListKitScreenViewModel {
    weak var view: SearchingIGListKitScreenViewProtocol?
    private var interactor: SearchingIGListKitScreenInteractorInputProtocol

    init(interactor: SearchingIGListKitScreenInteractorInputProtocol) {
        self.interactor = interactor
    }

}

// MARK: - SearchingIGListKitScreen ViewModelProtocol
extension SearchingIGListKitScreenViewModel: SearchingIGListKitScreenViewModelProtocol {
    func ongetListSearch(with keyword: String) {
        self.interactor.onHandleGetListSearch(with: keyword)
    }
    
    func onViewDidLoad() {
        self.interactor.onHandleGetData()
    }
    
    func openDetailView(id: String, category: Int) {
        self.interactor.onGetDetailMovie(id: id, category: category)
    }
    
    func onSearchWithKeyWork(with key: String) {
        self.interactor.onHandleSearchingWithKey(with: key)
    }
}

// MARK: - SearchingIGListKitScreen InteractorOutputProtocol
extension SearchingIGListKitScreenViewModel: SearchingIGListKitScreenInteractorOutputProtocol {
    func onGetListSearchingFinish(with data: [TopSearchData]) {
        self.view?.didGetSearchingListFinish(with: data)
    }
    
    func onGetSearchingListFinish(with data: [SearchingModelIG]) {
        self.view?.didGetListSearchingFinish(with: data)
    }
    
    func onGetDetailMovieFinish(with data: MovieDetail) {
        self.view?.didGetDetailViewFinish(with: data)
    }
    
    func onHandleGetDataFinish(with data: [TopSearchData]) {
        self.view?.onUpdateData(with: data)
    }
}
