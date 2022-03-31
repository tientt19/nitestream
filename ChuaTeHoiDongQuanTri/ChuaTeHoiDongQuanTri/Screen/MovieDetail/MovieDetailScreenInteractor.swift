//
//  MovieDetailScreenInteractor.swift
//  ChuaTeHoiDongQuanTri
//
//  Created by Valerian on 30/03/2022.
//  
//

import Foundation

class MovieDetailScreenInteractor: MovieDetailScreenInteractorInputProtocol {
    
    // MARK: Properties
    var presenter: MovieDetailScreenPresenterOutputProtocol?
    
    func loadMedia(_ contentID: String, _ category: Int, _ episodeID: Int, _ definition: String) {
        DataManager.shared.loadLinkMedia(contentID, category, episodeID, definition) { [weak self] response in
            guard let `self` = self else { return }
            if let data = response {
                self.presenter?.didGetLinkMedia(link: data)
            }
        }
    }
}
