//
//  
//  ChattingRouter.swift
//  nitestream
//
//  Created by Valerian on 20/06/2022.
//
//

import UIKit

// MARK: - RouterProtocol
protocol ChattingRouterProtocol {

}

// MARK: - Chatting Router
class ChattingRouter {
    weak var viewController: ChattingViewController?
    
    static func setupModule() -> ChattingViewController {
        let viewController = ChattingViewController()
        let router = ChattingRouter()
        let interactorInput = ChattingInteractorInput()
        let viewModel = ChattingViewModel(interactor: interactorInput)
        
        viewController.viewModel = viewModel
        viewController.router = router
        viewModel.view = viewController
        interactorInput.output = viewModel
        router.viewController = viewController
        
        return viewController
    }
}

// MARK: - Chatting RouterProtocol
extension ChattingRouter: ChattingRouterProtocol {
    
}
