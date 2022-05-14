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
}

// MARK: - StreamingMovieScreen InteractorOutputProtocol
extension StreamingMovieScreenViewModel: StreamingMovieScreenInteractorOutputProtocol {
    func onLoadLinkMediaFinish(with link: LinkMedia, info: MovieInfo, section: ListCollection, episodeVo: EpisodeCollection) {
        DispatchQueue.main.async {
            self.view?.onDidLoadLinkMedia(link: link, info: info, section: section, episodeVo: episodeVo)
        }
    }
}

