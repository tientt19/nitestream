//
//  
//  LoginScreenViewModel.swift
//  ChuTeHoiDongQuanTri
//
//  Created by Valerian on 19/05/2022.
//
//

import UIKit


// MARK: - ViewModelProtocol
protocol LoginScreenViewModelProtocol {
    func onViewDidLoad()
    func onLoginWithGoogle(with vc: UIViewController)
}

// MARK: - LoginScreen ViewModel
class LoginScreenViewModel {
    weak var view: LoginScreenViewProtocol?
    private var interactor: LoginScreenInteractorInputProtocol

    init(interactor: LoginScreenInteractorInputProtocol) {
        self.interactor = interactor
    }
}

// MARK: - LoginScreen ViewModelProtocol
extension LoginScreenViewModel: LoginScreenViewModelProtocol {
    func onLoginWithGoogle(with vc: UIViewController) {
        self.interactor.handleLoginWithGoogle(with: vc)
    }
    
    func onViewDidLoad() {
        
    }
}

// MARK: - LoginScreen InteractorOutputProtocol
extension LoginScreenViewModel: LoginScreenInteractorOutputProtocol {
    func didSigninByGoogle() {
        self.view?.goToHomeScreen()
    }
}
