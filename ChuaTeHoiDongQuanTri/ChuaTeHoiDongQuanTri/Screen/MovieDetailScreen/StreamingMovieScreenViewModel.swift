//
//  
//  StreamingMovieScreenViewModel.swift
//  ChuTeHoiDongQuanTri
//
//  Created by Valerian on 10/05/2022.
//
//

import UIKit
import StreamingTienPro

// MARK: - ViewModelProtocol
protocol StreamingMovieScreenViewModelProtocol {
    func onViewDidLoad(with data: MovieDetail?)
    func onGetMovieDetail(with data: DataModel?)
    func onLoadEpisode(with data: EpisodeVo)
}

// MARK: - StreamingMovieScreen ViewModel
class StreamingMovieScreenViewModel {
    weak var view: StreamingMovieScreenViewProtocol?
    private var interactor: StreamingMovieScreenInteractorInputProtocol

    init(interactor: StreamingMovieScreenInteractorInputProtocol) {
        self.interactor = interactor
    }
}

// MARK: - StreamingMovieScreen ViewModelProtocol
extension StreamingMovieScreenViewModel: StreamingMovieScreenViewModelProtocol {
    func onViewDidLoad(with data: MovieDetail?) {
        self.interactor.onLoadMedia(with: data!)        
    }
    
    func onGetMovieDetail(with data: DataModel?) {
        self.interactor.onHandleGetMovieDetail(with: data!)
    }
    
    func onLoadEpisode(with data: EpisodeVo) {
        self.interactor.onHandleEpisodeLoaded(with: data)
    }
}

// MARK: - StreamingMovieScreen InteractorOutputProtocol
extension StreamingMovieScreenViewModel: StreamingMovieScreenInteractorOutputProtocol {
    func onGetMovieDetil(with data: MovieDetail) {
        DispatchQueue.main.async {
            self.view?.onConfigureUI(with: data)
        }
    }
    
    func onLoadLinkMediaFinish(with link: LinkMedia, info: MovieInfo, section: ListCollection, episodeVo: EpisodeCollection) {
        DispatchQueue.main.async {
            self.view?.onDidLoadLinkMedia(link: link, info: info, section: section, episodeVo: episodeVo)
        }
    }
}

