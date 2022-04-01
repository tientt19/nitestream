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
}
