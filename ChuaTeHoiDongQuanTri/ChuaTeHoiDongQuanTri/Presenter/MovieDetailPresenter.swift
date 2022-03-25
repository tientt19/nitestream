//
//  MovieDetailPresenter.swift
//  ChuaTeHoiDongQuanTri
//
//  Created by Valerian on 28/02/2022.
//

import Foundation
import AVKit


protocol updateMovieDetail : AnyObject {
    func updateUI()
    func loadDetail()
}

class MovieDetailPresenter {
    var delegate : updateMovieDetail!
    
    let dispatchGroup = DispatchGroup()
    private var workItemGetHomePageData : DispatchWorkItem?
    private let queue = DispatchQueue(label: "com.tien.loadDetail")
    private var linkMediaResponse = LinkMedia(fromDictionary: ["" : ""])
    private var movieDetail = MovieDetail(fromDictionary: ["" : ""])
    
    var sections = [Section]()
    var episodeVo = [EpisodeVo]()
    var subRemoteURL = String()
    
    var contentHeight = Int()

    init(view : updateMovieDetail) {
        delegate = view
    }
    
    // MARK: - get link media
    func loadLinkMedia(_ contentID : String, _ category : Int, _ episodeID : Int, _ definition : String) {
        workItemGetHomePageData?.cancel()
                
        var newWorkItemGetHomePageData: DispatchWorkItem? = nil
        
        newWorkItemGetHomePageData = DispatchWorkItem { [weak self] in
            guard let _self = self else { return }
            if newWorkItemGetHomePageData?.isCancelled == true {
                _self.linkMediaResponse = LinkMedia(fromDictionary: ["" : ""])
                dLogDebug("work item cancel!")
                return
            }
        }
        
        ///enter to get place data
        dispatchGroup.enter()
        
        APIService.shared.getLinkMedia(contentId: contentID, categoty: category, episodeId: episodeID, definition: definition, closure: { [weak self] response, error in
            guard let _self = self else { return }
            
            if let data = response {
                _self.linkMediaResponse = data
                _self.dispatchGroup.leave()
            }
        })
        
        /// notify when work item done
        newWorkItemGetHomePageData?.notify(queue: queue) {
            self.dispatchGroup.wait()
            self.delegate.updateUI()
        }
        
        /// execute work item at background
        queue.async(execute: newWorkItemGetHomePageData!)
        workItemGetHomePageData = newWorkItemGetHomePageData
    }
    
    //MARK: - Get movie detail
    func getMovieDetail(_ id: Int,_ category: Int) {
        
        sections = []
        
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
            self.delegate.loadDetail()
        }
        
        /// execute work item at background
        queue.async(execute: newWorkItemGetHomePageData!)
        workItemGetHomePageData = newWorkItemGetHomePageData
    }
    
    func getDetailMovie() -> MovieDetail {
        return movieDetail
    }
    
    func getLinkMedia() -> LinkMedia {
        return linkMediaResponse
    }
    
    func getContentHeigt() -> CGFloat {
        return CGFloat(contentHeight)
    }
    
    //MARK: - get Episode
    func defaultVatlue(data : MovieDetail) -> MovieDetail {
        movieDetail = data
        return movieDetail
    }
    
    func getLinkSub(_ seriesNo: Int) -> String{
        if let subLinks = movieDetail.episodeVo[seriesNo].subtitlingList {
            for item in subLinks {
                if item.languageAbbr == "vi" {
                    self.subRemoteURL = item.subtitlingUrl
                }
            }
            
            if subRemoteURL == "" {
                for item in subLinks {
                    if item.languageAbbr == "en" {
                        self.subRemoteURL = item.subtitlingUrl
                    }
                }
            }
        }
        return self.subRemoteURL
    }
    
    func configureToSection() {
        if let episodeList = movieDetail.episodeVo {
            if episodeList.count > 1 {
                self.episodeVo = episodeList
                sections.append(Section(data: [DataModel](), title: "Episodes"))
                let parentWidth = UIScreen.main.bounds.width - 10*2
                let x = (episodeList.count * 50)
                if x > Int(parentWidth) {
                    let lines = (x / Int(parentWidth)) + 1
                    contentHeight += (lines * 50) + 70
                } else {
                    contentHeight += 120
                }
            }
        }
        
        if let reflist = movieDetail.refList {
            if reflist.count != 0 {
                var refLists = [DataModel]()
                reflist.forEach { data in
                    let dataItems = DataModel(id: data.id,
                                              category: data.category,
                                              name: data.name,
                                              coverHorizontalUrl: data.coverHorizontalUrl)
                    refLists.append(dataItems)
                }
                sections.append(Section(data: refLists, title: "In this series"))
                contentHeight += 70 + (((reflist.count)*80) + (reflist.count - 1)*5)
            }
        }
        
        if let likelist = movieDetail.likeList {
            if likelist.count != 0 {
                var likeLists = [DataModel]()
                likelist.forEach { data in
                    let dataItems = DataModel(id: data.id,
                                              category: data.category,
                                              name: data.name,
                                              coverHorizontalUrl: data.coverHorizontalUrl)
                    likeLists.append(dataItems)
                }
                sections.append(Section(data: likeLists, title: "Similar to this"))
                contentHeight += 70 + (((likelist.count)*80) + (likelist.count - 1)*5)
            }
        }
    }
    
    func getSectionData() -> [Section] {
        return sections
    }
    
    func getEpisodeList() -> [EpisodeVo] {
        return episodeVo
    }
    
}




