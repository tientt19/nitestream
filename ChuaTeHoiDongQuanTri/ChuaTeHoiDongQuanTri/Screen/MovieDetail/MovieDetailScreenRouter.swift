//
//  MovieDetailScreenRouter.swift
//  ChuaTeHoiDongQuanTri
//
//  Created by Valerian on 30/03/2022.
//  
//

import Foundation
import UIKit

class MovieDetailScreenRouter: MovieDetailScreenRouterProtocol {
    static var storyboard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
    // MARK: Static methods
    static func createModule() -> UIViewController {
        
        let viewController = MovieDetailScreenViewController()
                
        let presenter: MovieDetailScreenPresenterProtocol & MovieDetailScreenPresenterOutputProtocol = MovieDetailScreenPresenter()
        let interactor: MovieDetailScreenInteractorInputProtocol = MovieDetailScreenInteractor()
        let router = MovieDetailScreenRouter()
        
        viewController.presenter = presenter
        presenter.view = viewController
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
            
        return viewController
    }
    
}
