//
//  
//  StreamingMovieScreenRouter.swift
//  ChuTeHoiDongQuanTri
//
//  Created by Valerian on 10/05/2022.
//
//

import UIKit

// MARK: - RouterProtocol
protocol StreamingMovieScreenRouterProtocol {

}

// MARK: - StreamingMovieScreen Router
class StreamingMovieScreenRouter {
    weak var viewController: StreamingMovieScreenViewController?
    
    static func setupModule(with data: MovieDetail) -> StreamingMovieScreenViewController {
        let viewController = StreamingMovieScreenViewController()
        let router = StreamingMovieScreenRouter()
        let interactorInput = StreamingMovieScreenInteractorInput()
        let viewModel = StreamingMovieScreenViewModel(interactor: interactorInput)
        
        viewController.viewModel = viewModel
        viewController.router = router
        viewModel.view = viewController
        interactorInput.output = viewModel
        router.viewController = viewController
        viewController.movieDetail = data
        
        return viewController
    }
}

// MARK: - StreamingMovieScreen RouterProtocol
extension StreamingMovieScreenRouter: StreamingMovieScreenRouterProtocol {
    
}
