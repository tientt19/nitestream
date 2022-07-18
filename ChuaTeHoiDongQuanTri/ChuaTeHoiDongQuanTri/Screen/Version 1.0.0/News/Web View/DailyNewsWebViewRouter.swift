//
//  
//  DailyNewsWebViewRouter.swift
//  ChuTeHoiDongQuanTri
//
//  Created by Valerian on 04/06/2022.
//
//

import UIKit

// MARK: - RouterProtocol
protocol DailyNewsWebViewRouterProtocol {

}

// MARK: - DailyNewsWebView Router
class DailyNewsWebViewRouter {
    weak var viewController: DailyNewsWebViewViewController?
    
    static func setupModule(with model: NewsModel?) -> DailyNewsWebViewViewController {
        let viewController = DailyNewsWebViewViewController()
        let router = DailyNewsWebViewRouter()
        let interactorInput = DailyNewsWebViewInteractorInput()
        let viewModel = DailyNewsWebViewViewModel(interactor: interactorInput)
        
        viewController.model = model
        viewController.viewModel = viewModel
        viewController.router = router
        viewModel.view = viewController
        interactorInput.output = viewModel
        router.viewController = viewController
        
        return viewController
    }
}

// MARK: - DailyNewsWebView RouterProtocol
extension DailyNewsWebViewRouter: DailyNewsWebViewRouterProtocol {
    
}
