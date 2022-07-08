//
//  
//  DailyNewsWebViewViewModel.swift
//  ChuTeHoiDongQuanTri
//
//  Created by Valerian on 04/06/2022.
//
//

import UIKit

// MARK: - ViewModelProtocol
protocol DailyNewsWebViewViewModelProtocol {
    func onViewDidLoad()
}

// MARK: - DailyNewsWebView ViewModel
class DailyNewsWebViewViewModel {
    weak var view: DailyNewsWebViewViewProtocol?
    private var interactor: DailyNewsWebViewInteractorInputProtocol

    init(interactor: DailyNewsWebViewInteractorInputProtocol) {
        self.interactor = interactor
    }

}

// MARK: - DailyNewsWebView ViewModelProtocol
extension DailyNewsWebViewViewModel: DailyNewsWebViewViewModelProtocol {
    func onViewDidLoad() {
        
    }
}

// MARK: - DailyNewsWebView InteractorOutputProtocol
extension DailyNewsWebViewViewModel: DailyNewsWebViewInteractorOutputProtocol {

}
