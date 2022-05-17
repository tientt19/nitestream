//
//  
//  SearchingIGListKitScreenInteractorInput.swift
//  ChuTeHoiDongQuanTri
//
//  Created by Valerian on 05/05/2022.
//
//

import UIKit

// MARK: - Interactor Input Protocol
protocol SearchingIGListKitScreenInteractorInputProtocol {
    func onHandleGetData()
    func onGetDetailMovie(id: String, category: Int)
    func onHandleSearchingWithKey(with key: String)
    func onHandleGetListSearch(with keyword: String)
}

// MARK: - Interactor Output Protocol
protocol SearchingIGListKitScreenInteractorOutputProtocol: AnyObject {
    func onHandleGetDataFinish(with data: [TopSearchData])
    func onGetDetailMovieFinish(with data: MovieDetail)
    func onGetSearchingListFinish(with data: [SearchingModelIG])
    func onGetListSearchingFinish(with data: [TopSearchData])
}

// MARK: - SearchingIGListKitScreen InteractorInput
class SearchingIGListKitScreenInteractorInput {
    weak var output: SearchingIGListKitScreenInteractorOutputProtocol?
    private var pendingRequestWorkItem: DispatchWorkItem?
    private var workItemGetHomePageData : DispatchWorkItem?
    let dispatchGroup = DispatchGroup()

    private let queue = DispatchQueue(label: "com.tien.loadHomePage")
}

// MARK: - SearchingIGListKitScreen InteractorInputProtocol
extension SearchingIGListKitScreenInteractorInput: SearchingIGListKitScreenInteractorInputProtocol {
    func onHandleGetData() {
        DataManager.shared.getSearchingData { response in
            if let data = response {
                DispatchQueue.main.async {
                    self.output?.onHandleGetDataFinish(with: data)
                }
            }
        }
    }
    
    //MARK: - Get Detail Movie
    func onGetDetailMovie(id: String, category: Int) {
        DataManager.shared.getDetailMovieData(Int(id)!, category) { response in
            if let data = response {
                self.output?.onGetDetailMovieFinish(with: data)
            }
        }
    }
    
    func onHandleSearchingWithKey(with key: String) {
        // Cancel the currently pending item
        self.pendingRequestWorkItem?.cancel()
        var listSearchingData = [SearchingModelIG]()

        // Wrap our request in a work item
        let requestWorkItem = DispatchWorkItem { [weak self] in
            guard let `self` = self else { return }
            APIService.shared.searchLenovo(with: key) { response, error in
                if let data = response {
                    for item in data {
                        let itemData = SearchingModelIG()
                        itemData.content = item
                        listSearchingData.append(itemData)
                    }
                    self.output?.onGetSearchingListFinish(with: listSearchingData)
                }
            }
        }
        // Save the new work item and execute it after 250 ms
        self.pendingRequestWorkItem = requestWorkItem
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(150),
                                      execute: requestWorkItem)
    }
    
    func onHandleGetListSearch(with keyword: String) {
        var listSearch = [TopSearchData]()
        APIService.shared.getSearchingResult(with: keyword) { [weak self] response, error in
            guard let `self` = self else { return }
            if let data = response {
                for item in data {
                    listSearch.append(TopSearchData(fromSearchingData: item))
                }
                self.output?.onGetListSearchingFinish(with: listSearch)
            }
        }
    }
}
