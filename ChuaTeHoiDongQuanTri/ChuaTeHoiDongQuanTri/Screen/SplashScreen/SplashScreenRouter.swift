//
//  
//  SplashScreenRouter.swift
//  ChuTeHoiDongQuanTri
//
//  Created by Valerian on 18/05/2022.
//
//

import UIKit

// MARK: - RouterProtocol
protocol SplashScreenRouterProtocol {
    func goToLoginScreen()
    func goToHomeScreen()
}

// MARK: - SplashScreen Router
class SplashScreenRouter {
    weak var viewController: SplashScreenViewController?
    
    static func setupModule() -> SplashScreenViewController {
        let viewController = SplashScreenViewController()
        let router = SplashScreenRouter()
        let interactorInput = SplashScreenInteractorInput()
        let viewModel = SplashScreenViewModel(interactor: interactorInput)
        
        viewController.viewModel = viewModel
        viewController.router = router
        viewModel.view = viewController
        interactorInput.output = viewModel
        router.viewController = viewController
        
        return viewController
    }
}

// MARK: - SplashScreen RouterProtocol
extension SplashScreenRouter: SplashScreenRouterProtocol {
    func goToLoginScreen() {
        let controller = LoginScreenRouter.setupModule()
        controller.modalPresentationStyle = .fullScreen
        self.viewController?.present(controller, animated: true)
    }
    
    func goToHomeScreen() {
        let controller = MainTabBarController()
        controller.modalPresentationStyle = .fullScreen
        self.viewController?.present(controller, animated: true)
        
//        let storyboard = UIStoryboard(name: "CircleTabbar", bundle: nil)
//        let controller = storyboard.instantiateViewController(withIdentifier: "myCircleTabbar")
//        controller.modalPresentationStyle = .fullScreen
//        self.viewController?.present(controller, animated: true)
    }
}

