//
//  MovieDetailScreenPresenter.swift
//  ChuaTeHoiDongQuanTri
//
//  Created by Valerian on 30/03/2022.
//  
//

import Foundation

class MovieDetailScreenPresenter: MovieDetailScreenPresenterProtocol {
    
    // MARK: Properties
    var view: MovieDetailScreenViewProtocol?
    var interactor: MovieDetailScreenInteractorInputProtocol?
    var router: MovieDetailScreenRouterProtocol?
    
    func handleFetching(_ data: MovieDetail) {
        interactor?.fetchingData(data)
    }

    
}

extension MovieDetailScreenPresenter {
    func getdata() {
        
    }
}

extension MovieDetailScreenPresenter : MovieDetailScreenPresenterOutputProtocol {
    
}
