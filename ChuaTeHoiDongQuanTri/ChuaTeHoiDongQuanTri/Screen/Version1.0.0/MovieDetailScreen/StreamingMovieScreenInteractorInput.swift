//
//  
//  StreamingMovieScreenInteractorInput.swift
//  ChuTeHoiDongQuanTri
//
//  Created by Valerian on 10/05/2022.
//
//

import UIKit

// MARK: - Interactor Input Protocol
protocol StreamingMovieScreenInteractorInputProtocol {
    func onLoadMedia(with data: MovieDetail)
    func onHandleGetMovieDetail(with data: DataModel)
    func onHandleEpisodeLoaded(with data: EpisodeVo)
}

// MARK: - Interactor Output Protocol
protocol StreamingMovieScreenInteractorOutputProtocol: AnyObject {
    func onGetMovieDetil(with data: MovieDetail)
    func onLoadLinkMediaFinish(with link: LinkMedia, info: MovieInfo, section: ListCollection, episodeVo: EpisodeCollection)
}

// MARK: - StreamingMovieScreen InteractorInput
class StreamingMovieScreenInteractorInput {
    weak var output: StreamingMovieScreenInteractorOutputProtocol?
    var sections = [Section]()
    var episodeVo: EpisodeVo?
    var movieDetail: MovieDetail?
    var listCollection: ListCollection?
    var listEspisode: EpisodeCollection?
}

// MARK: - StreamingMovieScreen InteractorInputProtocol
extension StreamingMovieScreenInteractorInput: StreamingMovieScreenInteractorInputProtocol {
    func onHandleEpisodeLoaded(with data: EpisodeVo) {
        self.episodeVo = data
        var linkMedia = LinkMedia(fromDictionary: ["":""])
        let movieInfo = MovieInfo(from: self.movieDetail!)
        if let episodeID = data.id,
           let definition = data.definitionList[0].code {
            DataManager.shared.loadLinkMedia((self.movieDetail?.id)!, self.movieDetail!.category, episodeID, definition) { response in
                if let dataRespone = response {
                    linkMedia = dataRespone
                    self.output?.onLoadLinkMediaFinish(with: linkMedia, info: movieInfo, section: self.listCollection!, episodeVo: self.listEspisode!)
                }
            }
        }
    }
    
    func onLoadMedia(with data: MovieDetail) {
        // Get Link Media
        let listEpisode = data.episodeVo.map { x in x.id }
        guard let definition = data.episodeVo[0].definitionList[0].code else { return }
        let movieInfo = MovieInfo(from: data)
        self.movieDetail = data
        self.movieDetail?.seriesNo = self.episodeVo?.seriesNo
        var linkMedia = LinkMedia(fromDictionary: ["":""])
        self.configureSection(with: data)
        
        DataManager.shared.loadLinkMedia(data.id, data.category, listEpisode[0] ?? -1, definition) { response in
            if let dataRespone = response {
                linkMedia = dataRespone
                self.output?.onGetMovieDetil(with: data)
                self.output?.onLoadLinkMediaFinish(with: linkMedia, info: movieInfo, section: self.listCollection!, episodeVo: self.listEspisode!)
            }
        }
    }
    
    func onHandleGetMovieDetail(with data: DataModel) {
        DataManager.shared.getDetailMovieData(Int(data.identifier) ?? -1, data.category) { response in
            if let data = response {
                self.sections.removeAll()
                self.onLoadMedia(with: data)
            }
        }
    }
    
    //MARK: - Configure Section
    func configureSection(with data: MovieDetail) {
        
        if let episodeList = data.episodeVo {
            if episodeList.count != 0 {
                episodeList.forEach { data in
                    self.listEspisode = EpisodeCollection(listEpisode: episodeList)
                }
            }
        }
        
        if let reflist = data.refList {
            if reflist.count != 0 {
                var refLists = [DataModel]()
                reflist.forEach { data in
                    let dataItems = DataModel(identifier: data.id,
                                              category: data.category,
                                              name: data.name,
                                              coverHorizontalUrl: data.coverHorizontalUrl)
                    refLists.append(dataItems)
                }
                self.sections.append(Section(data: refLists, title: FooterDetailSectionTypes.refList.rawValue))
            }
        }
        
        if let likelist = data.likeList {
            if likelist.count != 0 {
                var likeLists = [DataModel]()
                likelist.forEach { data in
                    let dataItems = DataModel(identifier: data.id,
                                              category: data.category,
                                              name: data.name,
                                              coverHorizontalUrl: data.coverHorizontalUrl)
                    likeLists.append(dataItems)
                }
                self.sections.append(Section(data: likeLists, title: FooterDetailSectionTypes.likeList.rawValue))
            }
        }
        
        self.listCollection = ListCollection(section: self.sections)
    }
}
