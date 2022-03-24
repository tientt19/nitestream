//
//  HomePagePresenter.swift
//  ChuaTeHoiDongQuanTri
//
//  Created by Valerian on 24/02/2022.
//

import Foundation

protocol UpdateHomePageDelegate : AnyObject {
    func updateUI()
    func responseMovieDetail()
}

class HomePagePresenter {

    var delegate : UpdateHomePageDelegate!
    var listResponseData = HomePageModel(fromDictionary: ["" : ""])
    var listTopSearch = [TopSearchData]()
    var movieDetail = MovieDetail(fromDictionary: ["" : ""])
    
    let dispatchGroup = DispatchGroup()
    private var workItemGetHomePageData : DispatchWorkItem?
    
    private let queue = DispatchQueue(label: "com.tien.loadHomePage")
    
    init(view : UpdateHomePageDelegate) {
        delegate = view
    }
    
    
    //MARK: - get homepage data
    func getHomePageData(page: Int) {
        
//        // khi người dùng ấn call resquest liên tục
//        workItemGetHomePageData?.cancel()
        
        let dispatchGroup = DispatchGroup()
        
        var newWorkItemGetHomePageData: DispatchWorkItem? = nil
        
        newWorkItemGetHomePageData = DispatchWorkItem { [weak self] in
            guard let _self = self else { return }
            if newWorkItemGetHomePageData?.isCancelled == true {
                _self.listResponseData = HomePageModel(fromDictionary: ["" : ""])
                _self.listTopSearch = []
                dLogDebug("work item cancel!")
                return
            }
        }
        
        ///enter to get place data
        dispatchGroup.enter()
        
        APIService.shared.getHomeData(numberOfPage: page) { [weak self] response, error in
            
            guard let _self = self else { return }
            
            if newWorkItemGetHomePageData?.isCancelled == true {
                _self.listResponseData = HomePageModel(fromDictionary: ["" : ""])
                dLogDebug("internal new work item cancel!")
                dispatchGroup.leave()
                return
            }
            
            if let data = response {
                if page > 0 {
                    _self.listResponseData.recommendItems += data.recommendItems
                } else {
                    data.recommendItems.remove(at: 0)
                    _self.listResponseData = data
                }
                dispatchGroup.leave()
            }
        }
        
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
            self.delegate.updateUI()
        }
        
        /// execute work item at background
        queue.async(execute: newWorkItemGetHomePageData!)
        workItemGetHomePageData = newWorkItemGetHomePageData
    }
    
    
    //MARK: - Get movie detail
    func getMovieDetail(_ id: Int,_ category: Int) {
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
        
        APIService.shared.getMovieDetail(id: id, category: category) { [weak self] response, error in
            
            guard let _self = self else { return }

            if let data = response {
                _self.movieDetail = data
                dispatchGroup.leave()
            }
        }
        
        /// notify when work item done
        newWorkItemGetHomePageData?.notify(queue: queue) {
            dispatchGroup.wait()
            self.delegate.responseMovieDetail()
        }
        
        /// execute work item at background
        queue.async(execute: newWorkItemGetHomePageData!)
        workItemGetHomePageData = newWorkItemGetHomePageData
    }
    
    //MARK: - Load more
    
    func loadMore(page : Int) {
        getHomePageData(page: page)
    }
    
    func getData() -> HomePageModel {
        return listResponseData
    }
    
    func getTopSearchData() -> [TopSearchData] {
        return listTopSearch
    }
    
    func getMovieDetail() -> MovieDetail {
        return movieDetail
    }
}
