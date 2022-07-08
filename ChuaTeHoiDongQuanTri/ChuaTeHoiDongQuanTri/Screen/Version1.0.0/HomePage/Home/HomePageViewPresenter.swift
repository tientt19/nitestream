//
//  HomePageViewPresenter.swift
//  ChuaTeHoiDongQuanTri
//
//  Created by Valerian on 01/04/2022.
//  
//

import Foundation
import UIKit

class HomePageViewPresenter: HomePageViewPresenterProtocol {
    // MARK: Properties
    var view: HomePageViewViewProtocol?
    var interactor: HomePageViewInteractorInputProtocol?
    var router: HomePageViewRouterProtocol?
    
    var homePageAlbumsDAO: HomePageModels?
    var homePageBannerDAO: [HomeBannerModels]?
      
    func getMovieDetail(_ id: Int, _ category: Int) {
        interactor?.getMovieDetail(id, category)
    }
    
    func onGetMovieDetail(_ id: Int, _ category: Int) {
        self.interactor?.getMovieDetail(id, category)
    }
    
    // New
    func onGetHomeAlbums(with page: Int) {
        self.interactor?.onGetHomeAlbums(with: page)
    }
    
    func onGetAlbumsDetail(with refID: Int, loadOn page: Int) {
        self.interactor?.onGetAlbumsDetail(with: refID, loadOn: page)
    }
}

extension HomePageViewPresenter : HomePageViewPresenterOutputProtocol {
    
    func didGetMovieDetail(_ data: MovieDetail) {
        DispatchQueue.main.async {
            self.router?.openDetailView(view: self.view!, data: data)
        }
    }

    func openExpandView(with data: HomeAlbumsDetailModels) {
        self.router?.openExpandView(from: self.view!, with: data)
    }
    
    //new
    func didGetHomePageAlbumsFinish(with result: Result<HomePageModels, APIError>) {
        switch result {
        case .success(let model):
            self.homePageAlbumsDAO = model
            self.interactor?.onGetHomeBanner()
        case .failure(let error):
            dLogDebug(error.message)
        }
    }
    
    func didGetHomeBannerFinish(with result: Result<[HomeBannerModels], APIError>) {
        switch result {
        case .success(let model):
            self.homePageBannerDAO = model
            self.view?.didGetHomePageFinish(with: self.homePageAlbumsDAO!, listBanners: self.homePageBannerDAO!)
        case .failure(let error):
            dLogDebug(error.message)
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

//MARK: - ErrorViewDelegate
extension HomePageViewPresenter: ErrorViewDelegate {
    func onRetryButtonDidTapped(_ errorView: UIView) {
        self.interactor?.onGetHomeAlbums(with: 1)
    }
}
