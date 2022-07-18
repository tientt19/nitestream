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
    func openDetailMovie(from view: SearchingIGListKitScreenViewProtocol, for data: MovieDetail)
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
    func openDetailMovie(from view: SearchingIGListKitScreenViewProtocol, for data: MovieDetail) {
        
        let detailScreen = StreamingMovieScreenRouter.setupModule(with: data)
        detailScreen.hidesBottomBarWhenPushed = true
        
        guard let viewVC = view as? UIViewController else {
            fatalError("Invalid View Protocol type")
        }
        
        viewVC.navigationController?.pushViewController(detailScreen, animated: true)
    }
}
