//
//  
//  PageTVSeriesRouter.swift
//  ChuTeHoiDongQuanTri
//
//  Created by Valerian on 16/04/2022.
//
//

import UIKit

// MARK: - RouterProtocol
protocol PageTVSeriesRouterProtocol {

}

// MARK: - PageTVSeries Router
class PageTVSeriesRouter {
    weak var viewController: PageTVSeriesViewController?
    
    static func setupModule() -> PageTVSeriesViewController {
        let viewController = PageTVSeriesViewController()
        let router = PageTVSeriesRouter()
        let interactorInput = PageTVSeriesInteractorInput()
        let viewModel = PageTVSeriesViewModel(interactor: interactorInput)
        
        viewController.viewModel = viewModel
        viewController.router = router
        viewModel.view = viewController
        interactorInput.output = viewModel
        router.viewController = viewController
        
        return viewController
    }
}

// MARK: - PageTVSeries RouterProtocol
extension PageTVSeriesRouter: PageTVSeriesRouterProtocol {
    
}
