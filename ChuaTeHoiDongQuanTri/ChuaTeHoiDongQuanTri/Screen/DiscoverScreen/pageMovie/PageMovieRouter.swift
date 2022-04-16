//
//  
//  PageMovieRouter.swift
//  ChuTeHoiDongQuanTri
//
//  Created by Valerian on 16/04/2022.
//
//

import UIKit

// MARK: - RouterProtocol
protocol PageMovieRouterProtocol {

}

// MARK: - PageMovie Router
class PageMovieRouter {
    weak var viewController: PageMovieViewController?
    
    static func setupModule() -> PageMovieViewController {
        let viewController = PageMovieViewController()
        let router = PageMovieRouter()
        let interactorInput = PageMovieInteractorInput()
        let viewModel = PageMovieViewModel(interactor: interactorInput)
        
        viewController.viewModel = viewModel
        viewController.router = router
        viewModel.view = viewController
        interactorInput.output = viewModel
        router.viewController = viewController
        
        return viewController
    }
}

// MARK: - PageMovie RouterProtocol
extension PageMovieRouter: PageMovieRouterProtocol {
    
}
