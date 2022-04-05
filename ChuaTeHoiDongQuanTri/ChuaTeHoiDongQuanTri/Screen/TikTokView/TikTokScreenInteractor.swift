//
//  TikTokScreenInteractor.swift
//  ChuaTeHoiDongQuanTri
//
//  Created by Valerian on 04/04/2022.
//  
//

import Foundation

class TikTokScreenInteractor: TikTokScreenInteractorInputProtocol {

    // MARK: Properties
    var presenter: TikTokScreenPresenterOutputProtocol?
    
    func fetching(with page : Int) {
        DataManager.shared.getTikTokMedia(with: page) { [weak self] response, listReview  in
            guard let `self` = self else { return }
            self.presenter?.didFetch(data: response!)
            self.presenter?.didGetListReview(data: listReview!)
        }
    }
    
    func loadMore(with page: Int) {
        DataManager.shared.getTikTokMedia(with: page) { [weak self] response, listReview  in
            guard let `self` = self else { return }
            self.presenter?.didLoadMore(tiktokModel: response!, reviewData: listReview!)
        }
    }
}
