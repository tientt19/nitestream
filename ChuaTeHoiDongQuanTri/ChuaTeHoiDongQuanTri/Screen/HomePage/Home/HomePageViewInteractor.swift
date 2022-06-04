//
//  HomePageViewInteractor.swift
//  ChuaTeHoiDongQuanTri
//
//  Created by Valerian on 01/04/2022.
//  
//

import Foundation

class HomePageViewInteractor: HomePageViewInteractorInputProtocol {

    // MARK: Properties
    var presenter: HomePageViewPresenterOutputProtocol?
    let homePageService = HomePageService()
    
    // old
    func getHomeData(_ page: Int) {
        DataManager.shared.getHomeData(page: page) { [weak self] response in
            guard let `self` = self else { return }
            if let data = response {
                self.presenter?.didGetHomeData(data)
            }
        }
    }
    
    func getMovieDetail(_ id: Int, _ category: Int) {
        DataManager.shared.getDetailMovieData(id, category) {[weak self] response in
            guard let `self` = self else { return }
            if let data = response {
                self.presenter?.didGetMovieDetail(data)
            }
        }
    }
    
    func loadMore(_ page: Int, _ oldDAO: HomePageModel) {
        DataManager.shared.getHomeData(page: page) { [weak self] response in
            guard let `self` = self else { return }
            if let data = response {
                if page > 0 {
                    let dataRespone = data.recommendItems.filter { $0.recommendContentVOList.count > 1 }
                    data.recommendItems = dataRespone
                    oldDAO.recommendItems += data.recommendItems
                } else {
                    data.recommendItems.remove(at: 0)
                    let dataRespone = data.recommendItems.filter { $0.recommendContentVOList.count > 1 }
                    data.recommendItems = dataRespone
                    oldDAO.recommendItems += data.recommendItems
                }
                self.presenter?.didLoad(oldDAO)
            }
        }
    }
    
    // new
    func onGetHomeAlbums(with page: Int) {
        self.homePageService.onGetSingleAlbums(with: page) { [weak self] result in
            self?.presenter?.didGetHomePageAlbumsFinish(with: result.unwrapSuccessModel())
        }
    }
    
    func onGetHomeBanner() {
        self.homePageService.onGetHomeBanner { [weak self] result in
            self?.presenter?.didGetHomeBannerFinish(with: result.unwrapSuccessModel())
        }
    }
}
