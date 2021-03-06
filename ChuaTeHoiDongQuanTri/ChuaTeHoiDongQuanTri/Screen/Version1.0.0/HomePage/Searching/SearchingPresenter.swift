//
//  SearchingPresenter.swift
//  ChuaTeHoiDongQuanTri
//
//  Created by Valerian on 28/03/2022.
//

import Foundation


class SearchingPresenter : SearchingPresenterProtocols {

    weak var view: SearchingViewProtocols?
    var interactor: SearchingInteratorInputProtocols?
    var router: SearchingRouterProtocols?
    
    func callToGetTopSearchingData() {
        interactor?.handleGetData()
    }
    
    func openDetailView(id: String, category: Int) {
        interactor?.handleGetDetailMovie(id: id, category: category)
    }
    
    func handleSearchWithKeywork(_ keyword: String) {
        interactor?.handleSearchWithKeyword(keyword: keyword)
    }
    
    func getListSearch(_ keyword: String) {
        interactor?.handleGetListSearch(keyword)
    }
}

//MARK: - SearchingInteractorOutputProtocols
extension SearchingPresenter : SearchingInteractorOutputProtocols {
    func didGetListSearch(_ data: [TopSearchData]) {
        self.view?.reloadTableView(tableViewDataSource: SearchTableViewDataSource(entities: data, with: self))
    }
    
    func didGetDataSearch(_ data: [String]) {
        DispatchQueue.main.async {
            self.view?.reloadSearchingTableView(data)
        }
    }
    
    func didGetMovieDetail(_ data: MovieDetail) {
        DispatchQueue.main.async {
            self.router?.openDetailMovie(from: self.view!, for: data)
        }
    }
    
    func didGetData(_ data: [TopSearchData]) {
        DispatchQueue.main.async {
            self.view?.reloadTableView(tableViewDataSource: SearchTableViewDataSource(entities: data, with: self))
        }
    }
}
