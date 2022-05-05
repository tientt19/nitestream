//
//  
//  SearchingIGListKitScreenRouter.swift
//  ChuTeHoiDongQuanTri
//
//  Created by Valerian on 05/05/2022.
//
//

import UIKit

// MARK: - RouterProtocol
protocol SearchingIGListKitScreenRouterProtocol {

}

// MARK: - SearchingIGListKitScreen Router
class SearchingIGListKitScreenRouter {
    weak var viewController: SearchingIGListKitScreenViewController?
    
    static func setupModule() -> SearchingIGListKitScreenViewController {
        let viewController = SearchingIGListKitScreenViewController()
        let router = SearchingIGListKitScreenRouter()
        let interactorInput = SearchingIGListKitScreenInteractorInput()
        let viewModel = SearchingIGListKitScreenViewModel(interactor: interactorInput)
        
        viewController.viewModel = viewModel
        viewController.router = router
        viewModel.view = viewController
        interactorInput.output = viewModel
        router.viewController = viewController
        
        return viewController
    }
}

// MARK: - SearchingIGListKitScreen RouterProtocol
extension SearchingIGListKitScreenRouter: SearchingIGListKitScreenRouterProtocol {
    
}
