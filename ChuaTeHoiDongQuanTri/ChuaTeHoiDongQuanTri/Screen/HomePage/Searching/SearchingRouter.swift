//
//  SearchingRouter.swift
//  ChuaTeHoiDongQuanTri
//
//  Created by Valerian on 28/03/2022.
//

import Foundation
import UIKit

class SearchingRouter : SearchingRouterProtocols {

    static var storyboard: UIStoryboard {
          return UIStoryboard(name: "Main", bundle: Bundle.main)
      }
    
    static func createSearchingModule() -> UIViewController {
        let searchingViewController = SearchingViewController()
        
        let presenter: SearchingPresenterProtocols & SearchingInteractorOutputProtocols = SearchingPresenter()
        let interactor: SearchingInteratorInputProtocols = SearchingInterator()
        let router = SearchingRouter()
        
        searchingViewController.presenter = presenter
        presenter.view = searchingViewController
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        
        return searchingViewController
    }
    
    func openDetailMovie(from view: SearchingViewProtocols, for data: MovieDetail) {
        
        let detailVC = StreamingMovieScreenRouter.setupModule(with: data)
        
        guard let viewVC = view as? UIViewController else {
            fatalError("Invalid View Protocol type")
        }
        
        viewVC.navigationController?.pushViewController(detailVC, animated: true)
    }
}
