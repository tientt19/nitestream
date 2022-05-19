//
//  
//  ProfileScreenRouter.swift
//  ChuTeHoiDongQuanTri
//
//  Created by Valerian on 19/05/2022.
//
//

import UIKit

// MARK: - RouterProtocol
protocol ProfileScreenRouterProtocol {
    func goToLoginScreen()
}

// MARK: - ProfileScreen Router
class ProfileScreenRouter {
    weak var viewController: ProfileScreenViewController?
    
    static func setupModule() -> ProfileScreenViewController {
        let viewController = ProfileScreenViewController()
        let router = ProfileScreenRouter()
        let interactorInput = ProfileScreenInteractorInput()
        let viewModel = ProfileScreenViewModel(interactor: interactorInput)
        
        viewController.viewModel = viewModel
        viewController.router = router
        viewModel.view = viewController
        interactorInput.output = viewModel
        router.viewController = viewController
        
        return viewController
    }
}

// MARK: - ProfileScreen RouterProtocol
extension ProfileScreenRouter: ProfileScreenRouterProtocol {
    func goToLoginScreen() {
        let controller = LoginScreenRouter.setupModule()
        controller.modalPresentationStyle = .fullScreen
        self.viewController?.present(controller, animated: true)
    }
}
