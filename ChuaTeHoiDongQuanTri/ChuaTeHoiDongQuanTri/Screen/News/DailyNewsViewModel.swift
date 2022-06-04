//
//  
//  DailyNewsViewModel.swift
//  ChuTeHoiDongQuanTri
//
//  Created by Valerian on 31/05/2022.
//
//

import UIKit

// MARK: - ViewModelProtocol
protocol DailyNewsViewModelProtocol {
    func onViewDidLoad()
    func onLoadMoreData(with page: Int)
}

// MARK: - DailyNews ViewModel
class DailyNewsViewModel {
    weak var view: DailyNewsViewProtocol?
    private var interactor: DailyNewsInteractorInputProtocol

    init(interactor: DailyNewsInteractorInputProtocol) {
        self.interactor = interactor
    }

}

// MARK: - DailyNews ViewModelProtocol
extension DailyNewsViewModel: DailyNewsViewModelProtocol {
    func onViewDidLoad() {
        self.interactor.onGetDailyNewsData(with: 0)
    }
    
    func onLoadMoreData(with page: Int) {
        self.interactor.onGetDailyNewsData(with: page)
    }
}

// MARK: - DailyNews InteractorOutputProtocol
extension DailyNewsViewModel: DailyNewsInteractorOutputProtocol {
    func didGetNewsDataFinished(with result: Result<DailyNewsModel, APIError>) {
        switch result {
        case .success(let model):
            self.view?.onReceiveDaiyNewsData(with: model)
        case .failure(let error):
            dLogDebug(error.message)
        }
    }
}
