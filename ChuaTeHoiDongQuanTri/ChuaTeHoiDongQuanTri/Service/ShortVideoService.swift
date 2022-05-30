//
//  ShortVideoService.swift
//  ChuTeHoiDongQuanTri
//
//  Created by Valerian on 30/05/2022.
//

import Foundation

protocol ShortVideoServiceProtocols: AnyObject {
    func onGetShortVideo(completion: @escaping ((Result<BaseModel<[ShortVideoModel]>, APIError>) -> Void))
    func onGetReviewShortVideo(with page: Int?, completion: @escaping ((Result<BaseModel<[ReviewShortVideoModel]>, APIError>) -> Void))
}

//MARK: - ShortVideoServiceProtocols
class ShortVideoService: ShortVideoServiceProtocols {
    private let service = BaseService.shared
    
    func onGetShortVideo(completion: @escaping ((Result<BaseModel<[ShortVideoModel]>, APIError>) -> Void)) {
        let url = URLTypes.shortVideoURL.path
        self.service.GET(url: url,
                         param: nil,
                         completion: completion)
    }
    
    func onGetReviewShortVideo(with page: Int?, completion: @escaping ((Result<BaseModel<[ReviewShortVideoModel]>, APIError>) -> Void)) {
        let url = URLTypes.reviewShortVideo(page).path
        self.service.GET(url: url,
                         param: nil,
                         completion: completion)
    }
}
