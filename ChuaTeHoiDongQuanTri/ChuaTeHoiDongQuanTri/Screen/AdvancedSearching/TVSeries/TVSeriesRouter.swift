//
//  
//  TVSeriesRouter.swift
//  ChuTeHoiDongQuanTri
//
//  Created by Valerian on 11/06/2022.
//
//

import UIKit

// MARK: - RouterProtocol
protocol TVSeriesRouterProtocol {

}

// MARK: - TVSeries Router
class TVSeriesRouter {
    weak var viewController: TVSeriesViewController?
    
    static func setupModule() -> TVSeriesViewController {
        let viewController = TVSeriesViewController()
        let router = TVSeriesRouter()
        let interactorInput = TVSeriesInteractorInput()
        let viewModel = TVSeriesViewModel(interactor: interactorInput)
        
        viewController.viewModel = viewModel
        viewController.router = router
        viewModel.view = viewController
        interactorInput.output = viewModel
        router.viewController = viewController
        
        return viewController
    }
}

// MARK: - TVSeries RouterProtocol
extension TVSeriesRouter: TVSeriesRouterProtocol {
    
}
