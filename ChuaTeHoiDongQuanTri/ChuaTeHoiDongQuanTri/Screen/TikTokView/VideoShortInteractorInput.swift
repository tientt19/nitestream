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
    func onLoadMore(with page: Int)
    func onGetShortVideoData(with rawBody: [ReviewShortVideoModel])
}

// MARK: - Interactor Output Protocol
protocol VideoShortInteractorOutputProtocol: AnyObject {
    func didGetDataFinished(with result: Result<[ReviewShortVideoModel], APIError>)
    func didGetShortVideoFinish(with result: [ShortVideoModel])
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
            self?.output?.didGetDataFinished(with: result.unwrapSuccessModel())
        }
    }
    
    func onLoadMore(with page: Int) {
        self.service.onGetReviewShortVideo(with: page) { [weak self] result in
            self?.output?.didGetDataFinished(with: result.unwrapSuccessModel())
        }
    }
    
    func onGetShortVideoData(with rawBody: [ReviewShortVideoModel]) {
        let params = self.service.onGetRawBody(with: rawBody)
        self.service.onGetShortVideo(with: params) { [weak self] result, error in
            if let `result` = result {
                self?.output?.didGetShortVideoFinish(with: result)
            }
        }
    }
}
