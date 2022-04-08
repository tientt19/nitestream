//
//  SearchingInterator.swift
//  ChuaTeHoiDongQuanTri
//
//  Created by Valerian on 28/03/2022.
//

import Foundation

class SearchingInterator : SearchingInteratorInputProtocols {

    
    private var workItemGetHomePageData : DispatchWorkItem?
    var presenter: SearchingInteractorOutputProtocols?
    let dispatchGroup = DispatchGroup()

    private let queue = DispatchQueue(label: "com.tien.loadHomePage")
    
    //MARK: - Get data from server
    func handleGetData() {
        DataManager.shared.getSearchingData { response in
            if let data = response {
                self.presenter?.didGetData(data)
            }
        }
    }
    
    //MARK: - Get Detail Movie
    func handleGetDetailMovie(id: String, category: Int) {
        DataManager.shared.getDetailMovieData(Int(id)!, category) { response in
            if let data = response {
                self.presenter?.didGetMovieDetail(data)
            }
        }
    }
}
