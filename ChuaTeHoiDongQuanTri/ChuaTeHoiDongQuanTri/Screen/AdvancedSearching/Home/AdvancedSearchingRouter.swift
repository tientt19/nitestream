//
//  
//  AdvancedSearchingRouter.swift
//  ChuTeHoiDongQuanTri
//
//  Created by Valerian on 11/06/2022.
//
//

import UIKit

// MARK: - RouterProtocol
protocol AdvancedSearchingRouterProtocol {

}

// MARK: - AdvancedSearching Router
class AdvancedSearchingRouter {
    weak var viewController: AdvancedSearchingViewController?
    
    static func setupModule() -> AdvancedSearchingViewController {
        let viewController = AdvancedSearchingViewController()
        let router = AdvancedSearchingRouter()
        let interactorInput = AdvancedSearchingInteractorInput()
        let viewModel = AdvancedSearchingViewModel(interactor: interactorInput)
        
        viewController.viewModel = viewModel
        viewController.router = router
        viewModel.view = viewController
        interactorInput.output = viewModel
        router.viewController = viewController
        
        return viewController
    }
}

// MARK: - AdvancedSearching RouterProtocol
extension AdvancedSearchingRouter: AdvancedSearchingRouterProtocol {
    
}
