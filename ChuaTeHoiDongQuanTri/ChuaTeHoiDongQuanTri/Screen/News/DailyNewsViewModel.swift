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
        
    }
}

// MARK: - DailyNews InteractorOutputProtocol
extension DailyNewsViewModel: DailyNewsInteractorOutputProtocol {

}
