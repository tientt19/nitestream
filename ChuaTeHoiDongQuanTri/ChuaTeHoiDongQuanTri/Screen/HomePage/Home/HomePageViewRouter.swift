//
//  HomePageViewRouter.swift
//  ChuaTeHoiDongQuanTri
//
//  Created by Valerian on 01/04/2022.
//  
//

import Foundation
import UIKit

class HomePageViewRouter: HomePageViewRouterProtocol {
    
    static var storyboard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
    // MARK: Static methods
    static func createModule() -> UIViewController {
        
        let viewController = storyboard.instantiateViewController(withIdentifier: "HomePageViewViewController") as? HomePageViewViewController
        
        let presenter: HomePageViewPresenterProtocol & HomePageViewPresenterOutputProtocol = HomePageViewPresenter()
        let interactor: HomePageViewInteractorInputProtocol = HomePageViewInteractor()
        let router = HomePageViewRouter()
        
        viewController!.presenter = presenter
        presenter.view = viewController
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        
        return viewController!
    }
    
    func openDetailView(view: HomePageViewViewProtocol, data: MovieDetail) {
        
        let detailScreen = MovieDetailScreenRouter.createModule(data)
        detailScreen.hidesBottomBarWhenPushed = true

        guard let viewVC = view as? UIViewController else {
            fatalError("Invalid View Protocol type")
        }
        
        viewVC.navigationController?.pushViewController(detailScreen, animated: true)
    }
    
    func openExpandView(from view: HomePageViewViewProtocol, with data: RecommendItem) {
        let expandVC = ExpandScreenRouter.createModule(with: data)
        expandVC.hidesBottomBarWhenPushed = true
        guard let viewVC = view as? UIViewController else {
            fatalError("Invalid View Protocol type")
        }
        
        viewVC.navigationController?.pushViewController(expandVC, animated: true)
    }
}
