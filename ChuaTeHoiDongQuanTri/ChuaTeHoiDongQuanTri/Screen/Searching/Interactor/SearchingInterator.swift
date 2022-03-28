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
    var movieDetail = MovieDetail(fromDictionary: ["" : ""])
    var listTopSearch = [TopSearchData]()

    
    private let queue = DispatchQueue(label: "com.tien.loadHomePage")
    
    //MARK: - Get data from server
    func handleGetData() {
        let dispatchGroup = DispatchGroup()
        
        var newWorkItemGetHomePageData: DispatchWorkItem? = nil
        
        newWorkItemGetHomePageData = DispatchWorkItem { [weak self] in
            guard let _self = self else { return }
            if newWorkItemGetHomePageData?.isCancelled == true {
                _self.listTopSearch = []
                dLogDebug("work item cancel!")
                return
            }
        }
        
        ///enter to get place data
        dispatchGroup.enter()
    
        APIService.shared.getTopSearchData { [weak self] response, error in
            
            guard let _self = self else { return }
            
            if let data = response {
                _self.listTopSearch = data
                dispatchGroup.leave()
            }
        }
        
        /// notify when work item done
        newWorkItemGetHomePageData?.notify(queue: queue) {
            dispatchGroup.wait()
            self.presenter?.didGetData(self.listTopSearch)
        }
        
        /// execute work item at background
        queue.async(execute: newWorkItemGetHomePageData!)
        workItemGetHomePageData = newWorkItemGetHomePageData
    }
    
    //MARK: - Get Detail Movie
    func handleGetDetailMovie(id: String, category: Int) {
            // khi người dùng ấn call resquest liên tục
            workItemGetHomePageData?.cancel()
            
            let dispatchGroup = DispatchGroup()
            
            var newWorkItemGetHomePageData: DispatchWorkItem? = nil
            
            newWorkItemGetHomePageData = DispatchWorkItem { [weak self] in
                guard let _self = self else { return }
                if newWorkItemGetHomePageData?.isCancelled == true {
                    _self.movieDetail = MovieDetail(fromDictionary: ["" : ""])
                    dLogDebug("work item cancel!")
                    return
                }
            }
            
            ///enter to get place data
            dispatchGroup.enter()
            
        APIService.shared.getMovieDetail(id: Int(id)!, category: category) { [weak self] response, error in
                
                guard let _self = self else { return }

                if let data = response {
                    _self.movieDetail = data
                    dispatchGroup.leave()
                }
            }
            
            /// notify when work item done
            newWorkItemGetHomePageData?.notify(queue: queue) {
                dispatchGroup.wait()
                self.presenter?.didGetMovieDetail(self.movieDetail)
            }
            
            /// execute work item at background
            queue.async(execute: newWorkItemGetHomePageData!)
            workItemGetHomePageData = newWorkItemGetHomePageData
    }
}
