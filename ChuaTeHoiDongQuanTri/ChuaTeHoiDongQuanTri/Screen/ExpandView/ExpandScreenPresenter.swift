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

}

extension ExpandScreenPresenter : ExpandScreenPresenterOutputProtocol {
    func didGetMovieDetail(_ data: MovieDetail) {
        DispatchQueue.main.async {
            self.router?.openDetailMovie(from: self.view!, for: data)
        }
    }
}
