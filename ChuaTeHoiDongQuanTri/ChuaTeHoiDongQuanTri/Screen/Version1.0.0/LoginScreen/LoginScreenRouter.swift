//
//  
//  LoginScreenRouter.swift
//  ChuTeHoiDongQuanTri
//
//  Created by Valerian on 19/05/2022.
//
//

import UIKit

// MARK: - RouterProtocol
protocol LoginScreenRouterProtocol {
    func goToHomeScreen()
}

// MARK: - LoginScreen Router
class LoginScreenRouter {
    weak var viewController: LoginScreenViewController?
    
    static func setupModule() -> LoginScreenViewController {
        let viewController = LoginScreenViewController()
        let router = LoginScreenRouter()
        let interactorInput = LoginScreenInteractorInput()
        let viewModel = LoginScreenViewModel(interactor: interactorInput)
        
        viewController.viewModel = viewModel
        viewController.router = router
        viewModel.view = viewController
        interactorInput.output = viewModel
        router.viewController = viewController
        
        return viewController
    }
}

// MARK: - LoginScreen RouterProtocol
extension LoginScreenRouter: LoginScreenRouterProtocol {
    func goToHomeScreen() {
        let controller = MainTabBarController()
        controller.modalPresentationStyle = .fullScreen
        self.viewController?.present(controller, animated: true)
    }
}
