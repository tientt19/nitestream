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
}

extension HomePageViewPresenter : HomePageViewPresenterOutputProtocol {
    
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
}

