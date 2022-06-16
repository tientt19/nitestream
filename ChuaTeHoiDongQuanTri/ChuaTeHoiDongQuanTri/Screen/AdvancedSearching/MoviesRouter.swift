//
//  
//  MoviesRouter.swift
//  ChuTeHoiDongQuanTri
//
//  Created by Valerian on 11/06/2022.
//
//

import UIKit

// MARK: - RouterProtocol
protocol MoviesRouterProtocol {
    func openDetailView(data : MovieDetail)
}

// MARK: - Movies Router
class MoviesRouter {
    weak var viewController: MoviesViewController?
    
    static func setupModule() -> MoviesViewController {
        let viewController = MoviesViewController()
        let router = MoviesRouter()
        let interactorInput = MoviesInteractorInput()
        let viewModel = MoviesViewModel(interactor: interactorInput)
        
        viewController.viewModel = viewModel
        viewController.router = router
        viewModel.view = viewController
        interactorInput.output = viewModel
        router.viewController = viewController
        
        return viewController
    }
}

// MARK: - Movies RouterProtocol
extension MoviesRouter: MoviesRouterProtocol {
    func openDetailView(data : MovieDetail) {
        let detailScreen = StreamingMovieScreenRouter.setupModule(with: data)
        
        detailScreen.hidesBottomBarWhenPushed = true
        self.viewController?.present(detailScreen, animated: true)
    }
}
