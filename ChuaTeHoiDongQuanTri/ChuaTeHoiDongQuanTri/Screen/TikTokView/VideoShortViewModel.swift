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
}

// MARK: - VideoShort ViewModel
class VideoShortViewModel {
    weak var view: VideoShortViewProtocol?
    private var interactor: VideoShortInteractorInputProtocol

    init(interactor: VideoShortInteractorInputProtocol) {
        self.interactor = interactor
    }

}

// MARK: - VideoShort ViewModelProtocol
extension VideoShortViewModel: VideoShortViewModelProtocol {
    func onViewDidLoad() {
        self.interactor.onGetData()
    }
}

// MARK: - VideoShort InteractorOutputProtocol
extension VideoShortViewModel: VideoShortInteractorOutputProtocol {
    func didGetDataFinished(with result: Result<ReviewShortVideoModel, APIError>) {
        switch result {
        case .success(let model):
            dLogDebug(model)
        case .failure:
            dLogDebug("Failed")
        }
    }
}
