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
}

// MARK: - Interactor Output Protocol
protocol StreamingMovieScreenInteractorOutputProtocol: AnyObject {
    func onLoadLinkMediaFinish(with link: LinkMedia, info: MovieInfo, section: ListCollection, episodeVo: EpisodeCollection)
}

// MARK: - StreamingMovieScreen InteractorInput
class StreamingMovieScreenInteractorInput {
    weak var output: StreamingMovieScreenInteractorOutputProtocol?
    var sections = [Section]()
    var episodeVo = [EpisodeVo]()
    var listCollection: ListCollection?
    var listEspisode: EpisodeCollection?
}

// MARK: - StreamingMovieScreen InteractorInputProtocol
extension StreamingMovieScreenInteractorInput: StreamingMovieScreenInteractorInputProtocol {
    func onLoadMedia(with data: MovieDetail) {
        // Get Link Media
        let listEpisode = data.episodeVo.map { x in x.id }
        guard let definition = data.episodeVo[0].definitionList[0].code else { return }
        let movieInfo = MovieInfo(from: data)
        var linkMedia = LinkMedia(fromDictionary: ["":""])
        self.configureSection(with: data)
        
        DataManager.shared.loadLinkMedia(data.id, data.category, listEpisode[0] ?? -1, definition) { response in
            if let data = response {
                linkMedia = data
                self.output?.onLoadLinkMediaFinish(with: linkMedia, info: movieInfo, section: self.listCollection!, episodeVo: self.listEspisode!)
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
                sections.append(Section(data: likeLists, title: FooterDetailSectionTypes.likeList.rawValue))
            }
        }
        
        self.listCollection = ListCollection(section: self.sections)
//        //MARK: - Get Link Media
//        let listEpisode = data.episodeVo.map { x in x.id }
//        let definition = data.episodeVo[0].definitionList[0].code
//        presenter?.loadLinkMedia(entities.id, entities.category, listEpisode[0]!, definition!)
    }
}
