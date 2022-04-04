//
//  TikTokScreenRouter.swift
//  ChuaTeHoiDongQuanTri
//
//  Created by Valerian on 04/04/2022.
//  
//

import Foundation
import UIKit

class TikTokScreenRouter: TikTokScreenRouterProtocol {
    static var storyboard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
    // MARK: Static methods
    static func createModule() -> UIViewController {
        
        let viewController = storyboard.instantiateViewController(withIdentifier: "TikTokScreenViewController") as? TikTokScreenViewController
                
        let presenter: TikTokScreenPresenterProtocol & TikTokScreenPresenterOutputProtocol = TikTokScreenPresenter()
        let interactor: TikTokScreenInteractorInputProtocol = TikTokScreenInteractor()
        let router = TikTokScreenRouter()
        
        viewController!.presenter = presenter
        presenter.view = viewController
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
            
        return viewController!
    }
    
}
