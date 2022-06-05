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
    
    func getMovieDetail(_ id: Int, _ category: Int) {
        DataManager.shared.getDetailMovieData(id, category) {[weak self] response in
            guard let `self` = self else { return }
            if let data = response {
                self.presenter?.didGetMovieDetail(data)
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
    
    func onGetAlbumsDetail(with refID: Int, loadOn page: Int) {
        self.homePageService.onGetALbumsDetail(with: refID, loadOn: page) { [weak self] result in
            self?.presenter?.didGetAlbumsDetailFinish(with: result.unwrapSuccessModel())
        }
    }
}
