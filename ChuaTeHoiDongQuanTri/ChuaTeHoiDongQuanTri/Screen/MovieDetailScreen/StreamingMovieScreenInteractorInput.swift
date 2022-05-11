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
    func onLoadLinkMediaFinish(with link: LinkMedia, info: MovieInfo)
}

// MARK: - StreamingMovieScreen InteractorInput
class StreamingMovieScreenInteractorInput {
    weak var output: StreamingMovieScreenInteractorOutputProtocol?
}

// MARK: - StreamingMovieScreen InteractorInputProtocol
extension StreamingMovieScreenInteractorInput: StreamingMovieScreenInteractorInputProtocol {
    func onLoadMedia(with data: MovieDetail) {
        // Get Link Media
        let listEpisode = data.episodeVo.map { x in x.id }
        guard let definition = data.episodeVo[0].definitionList[0].code else { return }
        let movieInfo = MovieInfo(from: data)
        var linkMedia = LinkMedia(fromDictionary: ["":""])
        DataManager.shared.loadLinkMedia(data.id, data.category, listEpisode[0] ?? -1, definition) { response in
            if let data = response {
                linkMedia = data
                self.output?.onLoadLinkMediaFinish(with: linkMedia, info: movieInfo)
            }
        }
    }
}
