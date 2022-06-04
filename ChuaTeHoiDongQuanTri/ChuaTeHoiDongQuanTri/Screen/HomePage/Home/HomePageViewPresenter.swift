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
    var dataSource : HomePageViewDataSource?
    
    var homePageAlbumsDAO: HomePageModels?
    var homePageBannerDAO: [HomeBannerModels]?
    
    // Old
    func getHomePageData(_ page: Int) {
        interactor?.getHomeData(page)
    }
    
    func getMovieDetail(_ id: Int, _ category: Int) {
        interactor?.getMovieDetail(id, category)
    }
    
    func loadMore(_ page: Int, _ oldDAO: HomePageModel) {
        interactor?.loadMore(page, oldDAO)
    }
    
    func onGetMovieDetail(_ id: Int, _ category: Int) {
        self.interactor?.getMovieDetail(id, category)
    }
    
    // New
    func onGetHomeAlbums(with page: Int) {
        self.interactor?.onGetHomeAlbums(with: page)
    }
}

extension HomePageViewPresenter : HomePageViewPresenterOutputProtocol {
    // old
    func didGetMovieDetail(_ data: MovieDetail) {
        DispatchQueue.main.async {
            self.router?.openDetailView(view: self.view!, data: data)
        }
    }
    
    func didGetHomeData(_ data: HomePageModel) {
        DispatchQueue.main.async {
            self.view?.reloadData(data)
        }
    }
    
    func didLoad(_ data: HomePageModel) {
        DispatchQueue.main.async {
            self.view?.reloadData(data)
        }
    }
    
    func openExpandView(with data: RecommendItem) {
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
}

