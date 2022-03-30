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
    func getData(page : Int, completion : @escaping (_ response: [MainModel]?) -> Void) {
        var mainModelDAO = [MainModel]()
        workItemFetchData?.cancel()
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
        
        APIService.shared.getPlaceData(numberOfPage: page) { response, error in
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
//    func configureToSection(_ data : MovieDetail) {
//        if let episodeList = data.episodeVo {
//            if episodeList.count > 1 {
//                self.episodeVo = episodeList
//                sections.append(Section(data: [DataModel](), title: "Episodes"))
//                let parentWidth = UIScreen.main.bounds.width - 10*2
//                let x = (episodeList.count * 50)
//                if x > Int(parentWidth) {
//                    let lines = (x / Int(parentWidth)) + 1
//                    contentHeight += (lines * 50) + 70
//                } else {
//                    contentHeight += 120
//                }
//            }
//        }
//        
//        if let reflist = data.refList {
//            if reflist.count != 0 {
//                var refLists = [DataModel]()
//                reflist.forEach { data in
//                    let dataItems = DataModel(id: data.id,
//                                              category: data.category,
//                                              name: data.name,
//                                              coverHorizontalUrl: data.coverHorizontalUrl)
//                    refLists.append(dataItems)
//                }
//                sections.append(Section(data: refLists, title: "In this series"))
//                contentHeight += 70 + (((reflist.count)*80) + (reflist.count - 1)*5)
//            }
//        }
//        
//        if let likelist = data.likeList {
//            if likelist.count != 0 {
//                var likeLists = [DataModel]()
//                likelist.forEach { data in
//                    let dataItems = DataModel(id: data.id,
//                                              category: data.category,
//                                              name: data.name,
//                                              coverHorizontalUrl: data.coverHorizontalUrl)
//                    likeLists.append(dataItems)
//                }
//                sections.append(Section(data: likeLists, title: "Similar to this"))
//                contentHeight += 70 + (((likelist.count)*80) + (likelist.count - 1)*5)
//            }
//        }
//    }
}
