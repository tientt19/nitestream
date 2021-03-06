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

//MARK: - Discovery Screen

extension DataManager {
    
}
