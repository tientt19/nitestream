//
//  
//  PageAnimeRouter.swift
//  ChuTeHoiDongQuanTri
//
//  Created by Valerian on 16/04/2022.
//
//

import UIKit

// MARK: - RouterProtocol
protocol PageAnimeRouterProtocol {

}

// MARK: - PageAnime Router
class PageAnimeRouter {
    weak var viewController: PageAnimeViewController?
    
    static func setupModule() -> PageAnimeViewController {
        let viewController = PageAnimeViewController()
        let router = PageAnimeRouter()
        let interactorInput = PageAnimeInteractorInput()
        let viewModel = PageAnimeViewModel(interactor: interactorInput)
        
        viewController.viewModel = viewModel
        viewController.router = router
        viewModel.view = viewController
        interactorInput.output = viewModel
        router.viewController = viewController
        
        return viewController
    }
}

// MARK: - PageAnime RouterProtocol
extension PageAnimeRouter: PageAnimeRouterProtocol {
    
}
