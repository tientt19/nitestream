//
//  ExpandScreenPresenter.swift
//  ChuaTeHoiDongQuanTri
//
//  Created by Valerian on 29/03/2022.
//  
//

import Foundation

class ExpandScreenPresenter: ExpandScreenPresenterProtocol {
    // MARK: Properties
    var view: ExpandScreenViewProtocol?
    var interactor: ExpandScreenInteractorInputProtocol?
    var router: ExpandScreenRouterProtocol?
    
    func onViewDidLoad() {
        
    }
    
    func openDetailView(id: Int, category: Int) {
        interactor?.handleGetDetailMovie(id: id, category: category)
    }
    
    func onGetAlbumsDetail(with refID: Int, loadOn page: Int) {
        self.interactor?.onGetAlbumsDetail(with: refID, loadOn: page)
    }
}

extension ExpandScreenPresenter : ExpandScreenPresenterOutputProtocol {

    func didGetMovieDetail(_ data: MovieDetail) {
        DispatchQueue.main.async {
            self.router?.openDetailMovie(from: self.view!, for: data)
        }
    }
    
    func didGetAlbumsDetailFinish(with result: Result<HomeAlbumsDetailModels, APIError>) {
        switch result {
        case .success(let model):
            self.view?.didGetAlbumsDetailFinish(with: model)
        case .failure(let error):
            dLogDebug(error.message)
        }
    }
}
