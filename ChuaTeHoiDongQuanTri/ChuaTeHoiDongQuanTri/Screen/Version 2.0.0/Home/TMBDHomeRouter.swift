//
//  
//  TMBDHomeRouter.swift
//  nitestream
//
//  Created by Valerian on 18/07/2022.
//
//

import UIKit

// MARK: - RouterProtocol
protocol TMBDHomeRouterProtocol {

}

// MARK: - TMBDHome Router
class TMBDHomeRouter {
    weak var viewController: TMBDHomeViewController?
    
    static func setupModule() -> TMBDHomeViewController {
        let viewController = TMBDHomeViewController()
        let router = TMBDHomeRouter()
        let interactorInput = TMBDHomeInteractorInput()
        let viewModel = TMBDHomeViewModel(interactor: interactorInput)
        
        viewController.viewModel = viewModel
        viewController.router = router
        viewModel.view = viewController
        interactorInput.output = viewModel
        router.viewController = viewController
        
        return viewController
    }
}

// MARK: - TMBDHome RouterProtocol
extension TMBDHomeRouter: TMBDHomeRouterProtocol {
    
}
