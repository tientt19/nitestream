//
//  
//  DailyNewsRouter.swift
//  ChuTeHoiDongQuanTri
//
//  Created by Valerian on 31/05/2022.
//
//

import UIKit

// MARK: - RouterProtocol
protocol DailyNewsRouterProtocol {

}

// MARK: - DailyNews Router
class DailyNewsRouter {
    weak var viewController: DailyNewsViewController?
    
    static func setupModule() -> DailyNewsViewController {
        let viewController = DailyNewsViewController()
        let router = DailyNewsRouter()
        let interactorInput = DailyNewsInteractorInput()
        let viewModel = DailyNewsViewModel(interactor: interactorInput)
        
        viewController.viewModel = viewModel
        viewController.router = router
        viewModel.view = viewController
        interactorInput.output = viewModel
        router.viewController = viewController
        
        return viewController
    }
}

// MARK: - DailyNews RouterProtocol
extension DailyNewsRouter: DailyNewsRouterProtocol {
    
}
