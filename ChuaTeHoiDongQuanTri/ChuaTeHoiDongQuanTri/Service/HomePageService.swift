//
//  HomePageService.swift
//  ChuTeHoiDongQuanTri
//
//  Created by Valerian on 04/06/2022.
//

import Foundation

protocol HomePageServiceProtocols: AnyObject {
    func onGetSingleAlbums(with page: Int?, completion: @escaping ((Result<BaseModel<HomePageModels>, APIError>) -> Void))
    func onGetHomeBanner(completion: @escaping ((Result<BaseModel<[HomeBannerModels]>, APIError>) -> Void))
}

//MARK: - HomePageServiceProtocols
class HomePageService: HomePageServiceProtocols {
    private let service = BaseService.shared
    
    func onGetSingleAlbums(with page: Int?, completion: @escaping ((Result<BaseModel<HomePageModels>, APIError>) -> Void)) {
        let urlString = URLTypes.homePage(page).path
        self.service.GET(url: urlString,
                         param: nil,
                         completion: completion)
    }
    func onGetHomeBanner(completion: @escaping ((Result<BaseModel<[HomeBannerModels]>, APIError>) -> Void)) {
        let urlString = URLTypes.bannerHomePage.path
        self.service.GET(url: urlString,
                         param: nil,
                         completion: completion)
    }
    
}
