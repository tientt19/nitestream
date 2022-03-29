//
//  ExpandScreenRouter.swift
//  ChuaTeHoiDongQuanTri
//
//  Created by Valerian on 29/03/2022.
//  
//

import Foundation
import UIKit

class ExpandScreenRouter: ExpandScreenRouterProtocol {

    static var storyboard: UIStoryboard {
        return UIStoryboard(name: "ExpandScreen", bundle: Bundle.main)
    }
    // MARK: Static methods
    static func createModule(with data : RecommendItem) -> UIViewController {
        
        let viewController = storyboard.instantiateViewController(withIdentifier: "ExpandScreenViewController") as! ExpandScreenViewController
        viewController.listMoviePassed = data
                
        let presenter: ExpandScreenPresenterProtocol & ExpandScreenPresenterOutputProtocol = ExpandScreenPresenter()
        let interactor: ExpandScreenInteractorInputProtocol = ExpandScreenInteractor()
        let router = ExpandScreenRouter()
        
        viewController.presenter = presenter
        presenter.view = viewController
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
            
        return viewController
    }
    
    func openDetailMovie(from view: ExpandScreenViewProtocol, for data: MovieDetail) {
        guard let viewVC = view as? UIViewController else {
            fatalError("Invalid View Protocol type")
        }
        
        viewVC.navigationController?.pushViewController(MovieDetailVC(data), animated: true)
    }
}
