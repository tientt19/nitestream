//
//  
//  TVSeriesInteractorInput.swift
//  ChuTeHoiDongQuanTri
//
//  Created by Valerian on 11/06/2022.
//
//

import UIKit

// MARK: - Interactor Input Protocol
protocol TVSeriesInteractorInputProtocol {
    func onGetListSearch()
}

// MARK: - Interactor Output Protocol
protocol TVSeriesInteractorOutputProtocol: AnyObject {
    func didGetListSearchFinished(with result: Result<[SearchListModel], APIError>)
}

// MARK: - TVSeries InteractorInput
class TVSeriesInteractorInput {
    weak var output: TVSeriesInteractorOutputProtocol?
    let service = AdvancedSearchService()
}

// MARK: - TVSeries InteractorInputProtocol
extension TVSeriesInteractorInput: TVSeriesInteractorInputProtocol {
    func onGetListSearch() {
        self.service.onGetListSearch { [weak self] result in
            self?.output?.didGetListSearchFinished(with: result.unwrapSuccessModel())
        }
    }
}
