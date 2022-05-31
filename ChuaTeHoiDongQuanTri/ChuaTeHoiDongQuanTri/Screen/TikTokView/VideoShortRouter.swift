//
//  
//  VideoShortRouter.swift
//  ChuTeHoiDongQuanTri
//
//  Created by Valerian on 27/05/2022.
//
//

import UIKit

// MARK: - RouterProtocol
protocol VideoShortRouterProtocol {

}

// MARK: - VideoShort Router
class VideoShortRouter {
    weak var viewController: VideoShortViewController?
    
    static func setupModule() -> VideoShortViewController {
        let viewController = VideoShortViewController()
        let router = VideoShortRouter()
        let interactorInput = VideoShortInteractorInput()
        let viewModel = VideoShortViewModel(interactor: interactorInput)
        
        viewController.viewModel = viewModel
        viewController.router = router
        viewModel.view = viewController
        interactorInput.output = viewModel
        router.viewController = viewController
        
        return viewController
    }
}

// MARK: - VideoShort RouterProtocol
extension VideoShortRouter: VideoShortRouterProtocol {
    
}
