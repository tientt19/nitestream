//
//  
//  AnimeRouter.swift
//  ChuTeHoiDongQuanTri
//
//  Created by Valerian on 11/06/2022.
//
//

import UIKit

// MARK: - RouterProtocol
protocol AnimeRouterProtocol {
    func openDetailView(data : MovieDetail)
}

// MARK: - Anime Router
class AnimeRouter {
    weak var viewController: AnimeViewController?
    
    static func setupModule() -> AnimeViewController {
        let viewController = AnimeViewController()
        let router = AnimeRouter()
        let interactorInput = AnimeInteractorInput()
        let viewModel = AnimeViewModel(interactor: interactorInput)
        
        viewController.viewModel = viewModel
        viewController.router = router
        viewModel.view = viewController
        interactorInput.output = viewModel
        router.viewController = viewController
        
        return viewController
    }
}

// MARK: - Anime RouterProtocol
extension AnimeRouter: AnimeRouterProtocol {
    func openDetailView(data : MovieDetail) {
        let detailScreen = StreamingMovieScreenRouter.setupModule(with: data)
        
        detailScreen.hidesBottomBarWhenPushed = true
        self.viewController?.present(detailScreen, animated: true)
    }
}
