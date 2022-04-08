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
    
    func openDetail(with id: String, and category: Int) {
        interactor?.openDetail(with: id, and: category)
    }
}

extension TikTokScreenPresenter : TikTokScreenPresenterOutputProtocol {
    func didFetch(data: [TikTokModel], reviewData: ReviewMedia) {
        view?.showStreaming(data: data)
        view?.configureView(data: reviewData)
    }
    
    func didLoadMore(tiktokModel: [TikTokModel], reviewData: ReviewMedia) {
        view?.configureDataWhenLoadMore(tiktokModel, reviewData)

    }

    func didGetMovieDetail(_ data : MovieDetail) {
        DispatchQueue.main.async {
            self.router?.openDetailView(view: self.view!, data: data)
        }
    }
}
