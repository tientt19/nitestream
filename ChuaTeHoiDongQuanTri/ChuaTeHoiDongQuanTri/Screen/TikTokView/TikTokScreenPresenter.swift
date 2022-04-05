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
    
    func loadMore(with page: Int) {
        interactor?.loadMore(with: page)
    }
}

extension TikTokScreenPresenter : TikTokScreenPresenterOutputProtocol {
    func didLoadMore(tiktokModel: [TikTokModel], reviewData: [ReviewMedia]) {
        view?.configureDataWhenLoadMore(tiktokModel, reviewData)
    }
    
    func didGetListReview(data: [ReviewMedia]) {
        view?.configureView(data: data)
    }
    
    func didFetch(data: [TikTokModel]) {
        view?.showStreaming(data: data)
    }
}
