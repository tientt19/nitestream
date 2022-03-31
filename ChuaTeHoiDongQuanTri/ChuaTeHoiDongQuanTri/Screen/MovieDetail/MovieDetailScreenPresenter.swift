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
}

//MARK: - MovieDetailScreenPresenterOutputProtocol
extension MovieDetailScreenPresenter : MovieDetailScreenPresenterOutputProtocol {
    func didGetLinkMedia(link: LinkMedia) {
        DispatchQueue.main.async {
            self.view?.playMedia(link: link)
        }
    }
}
