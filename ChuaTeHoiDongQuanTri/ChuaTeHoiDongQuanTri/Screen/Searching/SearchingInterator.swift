//
//  SearchingInterator.swift
//  ChuaTeHoiDongQuanTri
//
//  Created by Valerian on 28/03/2022.
//

import Foundation

class SearchingInterator : SearchingInteratorInputProtocols {

    private var pendingRequestWorkItem: DispatchWorkItem?
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
    
    func handleSearchWithKeyword(keyword: String) {
        
        // Cancel the currently pending item
        pendingRequestWorkItem?.cancel()
        
        // Wrap our request in a work item
        let requestWorkItem = DispatchWorkItem { [weak self] in
            guard let `self` = self else { return }
            APIService.shared.searchLenovo(with: keyword) { response, error in
                if let data = response {
                    self.presenter?.didGetDataSearch(data)
                }
            }
        }
        // Save the new work item and execute it after 250 ms
        pendingRequestWorkItem = requestWorkItem
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(250),
                                      execute: requestWorkItem)
    }
    
    func handleGetListSearch(_ keyword: String) {
        var listSearch = [TopSearchData]()
        APIService.shared.getSearchingResult(with: keyword) { [weak self] response, error in
            guard let `self` = self else { return }
            if let data = response {
                for item in data {
                    listSearch.append(TopSearchData(fromSearchingData: item))
                }
                self.presenter?.didGetListSearch(listSearch)
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
