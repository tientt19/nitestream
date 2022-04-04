//
//  TikTokScreenPresenter.swift
//  ChuaTeHoiDongQuanTri
//
//  Created by Valerian on 04/04/2022.
//  
//

import Foundation

class TikTokScreenPresenter: TikTokScreenPresenterProtocol {


    // MARK: Properties
    var view: TikTokScreenViewProtocol?
    var interactor: TikTokScreenInteractorInputProtocol?
    var router: TikTokScreenRouterProtocol?
    
    func fetchData(with page: Int) {
        interactor?.fetching(with: page)
    }
    
}

extension TikTokScreenPresenter : TikTokScreenPresenterOutputProtocol {
    func didFetch(data: [TikTokModel]) {
        view?.showStreaming(data: data)
    }
}
