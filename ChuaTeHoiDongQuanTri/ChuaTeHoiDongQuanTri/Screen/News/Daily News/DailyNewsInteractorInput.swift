//
//  
//  DailyNewsInteractorInput.swift
//  ChuTeHoiDongQuanTri
//
//  Created by Valerian on 31/05/2022.
//
//

import UIKit

// MARK: - Interactor Input Protocol
protocol DailyNewsInteractorInputProtocol {
    func onGetDailyNewsData(with page: Int)
}

// MARK: - Interactor Output Protocol
protocol DailyNewsInteractorOutputProtocol: AnyObject {
    func didGetNewsDataFinished(with result: Result<DailyNewsModel, APIError>)
}

// MARK: - DailyNews InteractorInput
class DailyNewsInteractorInput {
    let service = DailyNewsService()

    weak var output: DailyNewsInteractorOutputProtocol?
}

// MARK: - DailyNews InteractorInputProtocol
extension DailyNewsInteractorInput: DailyNewsInteractorInputProtocol {
    func onGetDailyNewsData(with page: Int) {
        self.service.onGetListDailyNews(with: page) { [weak self] result in
            self?.output?.didGetNewsDataFinished(with: result.unwrapSuccessModel())
        }
    }
}
