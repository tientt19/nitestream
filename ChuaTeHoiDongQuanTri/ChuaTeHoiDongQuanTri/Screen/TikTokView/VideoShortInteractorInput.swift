//
//  
//  VideoShortInteractorInput.swift
//  ChuTeHoiDongQuanTri
//
//  Created by Valerian on 27/05/2022.
//
//

import UIKit

// MARK: - Interactor Input Protocol
protocol VideoShortInteractorInputProtocol {
    func onGetData()
}

// MARK: - Interactor Output Protocol
protocol VideoShortInteractorOutputProtocol: AnyObject {
    func didGetDataFinished(with result: Result<ReviewShortVideoModel, APIError>)
}

// MARK: - VideoShort InteractorInput
class VideoShortInteractorInput {
    let service = ShortVideoService()
    weak var output: VideoShortInteractorOutputProtocol?
}

// MARK: - VideoShort InteractorInputProtocol
extension VideoShortInteractorInput: VideoShortInteractorInputProtocol {
    func onGetData() {
        self.service.onGetReviewShortVideo(with: 0) { [weak self] result in
            dLogDebug(result)
//            self?.output?.didGetDataFinished(with: result.unwrapSuccessModel())
        }
    }
}
