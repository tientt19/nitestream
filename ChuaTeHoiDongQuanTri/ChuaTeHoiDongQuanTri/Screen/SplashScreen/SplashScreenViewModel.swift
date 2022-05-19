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
        
    }
}

// MARK: - SplashScreen InteractorOutputProtocol
extension SplashScreenViewModel: SplashScreenInteractorOutputProtocol {

}
