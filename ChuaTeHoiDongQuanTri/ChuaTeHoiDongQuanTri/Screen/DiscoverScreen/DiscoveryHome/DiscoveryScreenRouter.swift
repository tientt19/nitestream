//
//  
//  DiscoveryScreenRouter.swift
//  ChuTeHoiDongQuanTri
//
//  Created by admin on 05/04/2022.
//
//

import UIKit

class DiscoveryScreenRouter {
    weak var viewController: DiscoveryScreenViewController?
    
    static func setupModule() -> DiscoveryScreenViewController {
        let viewController = DiscoveryScreenViewController()
        let router = DiscoveryScreenRouter()
        let interactorInput = DiscoveryScreenInteractorInput()
        let presenter = DiscoveryScreenPresenter(interactor: interactorInput, router: router)
        viewController.presenter = presenter
        presenter.view = viewController
        interactorInput.output = presenter
        router.viewController = viewController
        return viewController
    }
}

// MARK: - DiscoveryScreenRouterProtocol
extension DiscoveryScreenRouter: DiscoveryScreenRouterProtocol {
    
}
