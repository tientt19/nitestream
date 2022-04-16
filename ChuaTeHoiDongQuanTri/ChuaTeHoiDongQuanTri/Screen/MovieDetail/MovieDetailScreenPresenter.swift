//
//  MovieDetailScreenPresenter.swift
//  ChuaTeHoiDongQuanTri
//
//  Created by Valerian on 30/03/2022.
//  
//

import Foundation

//MARK: - MovieDetailScreenPresenterProtocol
class MovieDetailScreenPresenter: MovieDetailScreenPresenterProtocol {


    // MARK: Properties
    var view: MovieDetailScreenViewProtocol?
    var interactor: MovieDetailScreenInteractorInputProtocol?
    var router: MovieDetailScreenRouterProtocol?
    
    func loadLinkMedia(_ contentID: String, _ category: Int, _ episodeID: Int, _ definition: String) {
        interactor?.loadMedia(contentID, category, episodeID, definition)
    }
    
    func getMovieDetail(_ id: String, _ category: Int) {
        interactor?.getData(id, category)
    }
    
}

//MARK: - MovieDetailScreenPresenterOutputProtocol
extension MovieDetailScreenPresenter : MovieDetailScreenPresenterOutputProtocol {
    func didGetMovieDetail(_ data: MovieDetail) {
        DispatchQueue.main.async {
            self.view?.configureNewData(data)
        }
    }
    
    func didGetLinkMedia(link: LinkMedia) {
        DispatchQueue.main.async {
            self.view?.playMedia(link: link)
        }
    }
}
