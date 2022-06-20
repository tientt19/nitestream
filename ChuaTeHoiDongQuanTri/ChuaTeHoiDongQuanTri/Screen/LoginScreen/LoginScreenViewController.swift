//
//  
//  LoginScreenViewController.swift
//  ChuTeHoiDongQuanTri
//
//  Created by Valerian on 19/05/2022.
//
//

import UIKit
import GoogleSignIn

// MARK: - ViewProtocol
protocol LoginScreenViewProtocol: AnyObject {
    func goToHomeScreen()
}

// MARK: - LoginScreen ViewController
class LoginScreenViewController: BaseViewController {
    var router: LoginScreenRouterProtocol!
    var viewModel: LoginScreenViewModelProtocol!
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupInit()
        self.viewModel.onViewDidLoad()
    }
    
    // MARK: - Init
    private func setupInit() {

    }
    
    // MARK: - Action
    @IBAction func googleSignInButtonTap(_ sender: Any) {
        self.viewModel.onLoginWithGoogle(with: self)
    }
}

// MARK: - LoginScreen ViewProtocol
extension LoginScreenViewController: LoginScreenViewProtocol {
    func goToHomeScreen() {
        self.router.goToHomeScreen()
    }
}
