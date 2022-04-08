//
//  DataManager.swift
//  ChuaTeHoiDongQuanTri
//
//  Created by Valerian on 30/03/2022.
//

import Foundation
import UIKit

class DataManager {
    static let shared = DataManager()
    
    private var workItemFetchData : DispatchWorkItem?
    private let queue = DispatchQueue(label: "com.tien.loadDataQueue")
    
}

//MARK: - Searching and Expand hanle task
extension DataManager {
    /// get data home page
    /// - Parameter page: page
    /// - Parameter completion: respone value
    func getHomeData(page : Int, completion : @escaping (_ response: HomePageModel?) -> Void) {
        workItemFetchData?.cancel()

        var mainModelDAO = HomePageModel(fromDictionary: ["":""])
        let dispatchGroup = DispatchGroup()
        
        var newWorkItemFetchData: DispatchWorkItem? = nil
        
        newWorkItemFetchData = DispatchWorkItem {
            if newWorkItemFetchData?.isCancelled == true {
                dLogDebug("work item cancel!")
                completion(nil)
                return
            }
        }
        ///enter to get place data
        dispatchGroup.enter()
        
        APIService.shared.getHomeData(numberOfPage: page) { response, error in
            if newWorkItemFetchData?.isCancelled == true {
                dLogDebug("internal new work item cancel!")
                dispatchGroup.leave()
                completion(nil)
                return
            }
            
            if let data = response {
                mainModelDAO = data
                dispatchGroup.leave()
            }
            completion(nil)
        }
        
        /// notify when work item done
        newWorkItemFetchData?.notify(queue: queue) {
            dispatchGroup.wait()
            completion(mainModelDAO)
        }
        
        /// execute work item at background
        queue.async(execute: newWorkItemFetchData!)
        workItemFetchData = newWorkItemFetchData
    }
    
    
    /// get searching data
    /// - Parameter completion: respone value
    func getSearchingData(completion : @escaping (_ response: [TopSearchData]?) -> Void) {
        workItemFetchData?.cancel()

        var searchingModelDAO = [TopSearchData]()
        let dispatchGroup = DispatchGroup()
        var newWorkItemFetchData: DispatchWorkItem? = nil
        
        newWorkItemFetchData = DispatchWorkItem {
            if newWorkItemFetchData?.isCancelled == true {
                dLogDebug("work item cancel!")
                completion(nil)
                return
            }
        }
        
        ///enter to get place data
        dispatchGroup.enter()
        
        APIService.shared.getTopSearchData { response, error in
            
            if let data = response {
                searchingModelDAO = data
                dispatchGroup.leave()
            }
            completion(nil)
        }
        
        /// notify when work item done
        newWorkItemFetchData?.notify(queue: queue) {
            dispatchGroup.wait()
            completion(searchingModelDAO)
        }
        
        /// execute work item at background
        queue.async(execute: newWorkItemFetchData!)
        workItemFetchData = newWorkItemFetchData
    }
    
    /// get movie detail
    /// - Parameters:
    ///   - id: id
    ///   - category: category
    ///   - completion: respone data
    func getDetailMovieData( _ id : Int, _ category : Int ,completion : @escaping (_ response: MovieDetail?) -> Void) {
        // khi người dùng ấn call resquest liên tục
        workItemFetchData?.cancel()

        var searchingModelDAO = MovieDetail(fromDictionary: ["":""])
        let dispatchGroup = DispatchGroup()
        var newWorkItemFetchData: DispatchWorkItem? = nil
        
        newWorkItemFetchData = DispatchWorkItem {
            if newWorkItemFetchData?.isCancelled == true {
                dLogDebug("work item cancel!")
                completion(nil)
                return
            }
        }
        
        ///enter to get place data
        dispatchGroup.enter()
        
        APIService.shared.getMovieDetail(id: id, category: category) { response, error in
            
            if let data = response {
                searchingModelDAO = data
                dispatchGroup.leave()
            }
            completion(nil)
        }
        
        /// notify when work item done
        newWorkItemFetchData?.notify(queue: queue) {
            dispatchGroup.wait()
            completion(searchingModelDAO)
        }
        
        /// execute work item at background
        queue.async(execute: newWorkItemFetchData!)
        workItemFetchData = newWorkItemFetchData
    }
}

//MARK: - Movie Detail
extension DataManager {
    // MARK: - get link media
    func loadLinkMedia(_ contentID : String, _ category : Int, _ episodeID : Int, _ definition : String, completion : @escaping (_ response: LinkMedia?) -> Void) {
        
        workItemFetchData?.cancel()
        
        let dispatchGroup = DispatchGroup()
        var linkMediaDAO = LinkMedia(fromDictionary: ["" : ""])
        
        var newWorkItemGetHomePageData: DispatchWorkItem? = nil
        
        newWorkItemGetHomePageData = DispatchWorkItem {
            if newWorkItemGetHomePageData?.isCancelled == true {
                completion(nil)
                dLogDebug("work item cancel!")
                return
            }
        }
        
        ///enter to get place data
        dispatchGroup.enter()
        
        APIService.shared.getLinkMedia(contentId: contentID, categoty: category, episodeId: episodeID, definition: definition, closure: {response, error in
            
            if let data = response {
                linkMediaDAO = data
                dispatchGroup.leave()
            }
            completion(nil)
        })
        
        /// notify when work item done
        newWorkItemGetHomePageData?.notify(queue: queue) {
            dispatchGroup.wait()
            completion(linkMediaDAO)
        }
        
        /// execute work item at background
        queue.async(execute: newWorkItemGetHomePageData!)
        workItemFetchData = newWorkItemGetHomePageData
    }
}

//MARK: - TikTok Screen

extension DataManager {
    /// get review media
    /// - Parameters:
    ///   - page: number of page
    ///   - completion: respone value
    func getReviewMedia(page : Int, completion : @escaping (_ response: [ReviewMedia]?) -> Void) {
        workItemFetchData?.cancel()
        
        let dispatchGroup = DispatchGroup()
        var mediaInfoDAO = [ReviewMedia]()
        
        var newWorkItemGetHomePageData: DispatchWorkItem? = nil
        
        newWorkItemGetHomePageData = DispatchWorkItem {
            if newWorkItemGetHomePageData?.isCancelled == true {
                completion(nil)
                dLogDebug("work item cancel!")
                return
            }
        }
        
        ///enter to get place data
        dispatchGroup.enter()
        
        APIService.shared.getReviewMedia(by: page) { response, error in
            if let data = response {
                mediaInfoDAO = data
            }
        }
        
        /// notify when work item done
        newWorkItemGetHomePageData?.notify(queue: queue) {
            dispatchGroup.wait()
            completion(mediaInfoDAO)
        }
        
        /// execute work item at background
        queue.async(execute: newWorkItemGetHomePageData!)
        workItemFetchData = newWorkItemGetHomePageData
    }
    
    func rawBody(with data : [ReviewMedia]) -> String {
        return "[\n  {\n    \"category\": \(String(describing: data.first?.category ?? 0)),\n    \"contentId\": \"\(String(describing: data.first?.id ?? ""))\",\n    \"episodeId\": \(String(describing: data.first?.mediaInfo.id ?? 0)),\n    \"definition\": \"\(String(describing: data.first?.mediaInfo.definitionList.first?.code ?? ""))\"\n  }\n]"
    }
    
    func getTikTokMedia(with page : Int, completion : @escaping (_ response: [TikTokModel]?, _ listReview : ReviewMedia?) -> Void) {
        APIService.shared.getReviewMedia(by: page) { response, error in
            if let data = response {
                let listReview = self.getReviewList(data)
                APIService.shared.getTikTokMedia(with: DataManager.shared.rawBody(with: data)) { response, error in
                    if let data = response {
                        completion(data, listReview)
                    } else { completion(nil,nil) }
                }
            }
        }
    }
    
    func getReviewList(_ data : [ReviewMedia]) -> ReviewMedia {
        return data.first!
    }
}
