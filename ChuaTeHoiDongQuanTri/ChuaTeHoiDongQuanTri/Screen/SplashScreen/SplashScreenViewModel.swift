//
//  
//  SplashScreenViewModel.swift
//  ChuTeHoiDongQuanTri
//
//  Created by Valerian on 18/05/2022.
//
//

import UIKit

// MARK: - ViewModelProtocol
protocol SplashScreenViewModelProtocol {
    func onViewDidLoad()
}

// MARK: - SplashScreen ViewModel
class SplashScreenViewModel {
    weak var view: SplashScreenViewProtocol?
    private var interactor: SplashScreenInteractorInputProtocol

    init(interactor: SplashScreenInteractorInputProtocol) {
        self.interactor = interactor
    }

}

// MARK: - SplashScreen ViewModelProtocol
extension SplashScreenViewModel: SplashScreenViewModelProtocol {
    func onViewDidLoad() {
        self.setInitHandleNetwork()
    }
    
    func setInitHandleNetwork() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.onInternetConnectionAvailable), name: .connectionAvailable, object: nil)
    }
    
    @objc func onInternetConnectionAvailable() {
        self.view?.onCheckAutoLogin()
    }
}

// MARK: - SplashScreen InteractorOutputProtocol
extension SplashScreenViewModel: SplashScreenInteractorOutputProtocol {

}

//MARK: - ErrorViewDelegate
extension SplashScreenViewModel: ErrorViewDelegate {
    func onRetryButtonDidTapped(_ errorView: UIView) {
        self.setInitHandleNetwork()
    }
}
