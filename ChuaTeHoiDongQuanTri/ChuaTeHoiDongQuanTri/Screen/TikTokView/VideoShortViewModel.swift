//
//  
//  VideoShortViewModel.swift
//  ChuTeHoiDongQuanTri
//
//  Created by Valerian on 27/05/2022.
//
//

import UIKit

// MARK: - ViewModelProtocol
protocol VideoShortViewModelProtocol {
    func onViewDidLoad()
    func onLoadMoreData(with page: Int)
}

// MARK: - VideoShort ViewModel
class VideoShortViewModel {
    weak var view: VideoShortViewProtocol?
    private var interactor: VideoShortInteractorInputProtocol
    var listItems: ReviewShortVideoModel?

    init(interactor: VideoShortInteractorInputProtocol) {
        self.interactor = interactor
    }

}

// MARK: - VideoShort ViewModelProtocol
extension VideoShortViewModel: VideoShortViewModelProtocol {
    func onViewDidLoad() {
        self.interactor.onGetData()
    }
    
    func onLoadMoreData(with page: Int) {
        self.interactor.onLoadMore(with: page)
    }
}

// MARK: - VideoShort InteractorOutputProtocol
extension VideoShortViewModel: VideoShortInteractorOutputProtocol {
    func didGetDataFinished(with result: Result<[ReviewShortVideoModel], APIError>) {
        switch result {
        case .success(let model):
            self.listItems = model.first
            self.interactor.onGetShortVideoData(with: model)
        case .failure(let error):
            dLogDebug(error.message)
        }
    }
    
    func didGetShortVideoFinish(with result: [ShortVideoModel]) {
        self.view?.onReceiveShortVideoData(with: result.first, info: self.listItems)
    }
}

//MARK: - ErrorViewDelegate
extension VideoShortViewModel: ErrorViewDelegate {
    func onRetryButtonDidTapped(_ errorView: UIView) {
        self.interactor.onGetData()
    }
}
