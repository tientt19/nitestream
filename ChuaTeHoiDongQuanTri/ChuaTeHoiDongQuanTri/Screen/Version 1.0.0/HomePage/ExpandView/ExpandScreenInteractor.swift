//
//  ExpandScreenInteractor.swift
//  ChuaTeHoiDongQuanTri
//
//  Created by Valerian on 29/03/2022.
//  
//

import Foundation

class ExpandScreenInteractor: ExpandScreenInteractorInputProtocol {
    
    private var workItemGetHomePageData : DispatchWorkItem?
    let dispatchGroup = DispatchGroup()
    var movieDetail = MovieDetail(fromDictionary: ["" : ""])
    let homePageService = HomePageService()

    private let queue = DispatchQueue(label: "com.tien.loadHomePage")
    
    // MARK: Properties
    var presenter: ExpandScreenPresenterOutputProtocol?
    
    func handleGetDetailMovie(id: Int, category: Int) {
        // khi người dùng ấn call resquest liên tục
        DataManager.shared.getDetailMovieData(id, category) { response in
            if let data = response {
                self.presenter?.didGetMovieDetail(data)
            }
        }
    }
    
    func onGetAlbumsDetail(with refID: Int, loadOn page: Int) {
        self.homePageService.onGetALbumsDetail(with: refID, loadOn: page) { [weak self] result in
            self?.presenter?.didGetAlbumsDetailFinish(with: result.unwrapSuccessModel())
        }
    }
}
