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
    func onLoginWithFacebook(viewController: UIViewController)
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
    func onViewDidLoad() {
        
    }
    
    func onLoginWithGoogle(with vc: UIViewController) {
        self.interactor.handleLoginWithGoogle(with: vc)
    }
    
    func onLoginWithFacebook(viewController: UIViewController) {
        self.interactor.handleLoginwithFacebook(viewController: viewController)
    }
}

// MARK: - LoginScreen InteractorOutputProtocol
extension LoginScreenViewModel: LoginScreenInteractorOutputProtocol {
    func didSigninByGoogle() {
        self.view?.goToHomeScreen()
    }
    
    func didSigninByFacebook() {
        self.view?.goToHomeScreen()
    }
}
