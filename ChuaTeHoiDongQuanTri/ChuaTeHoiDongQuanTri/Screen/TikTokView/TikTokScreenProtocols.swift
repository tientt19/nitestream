//
//  TikTokScreenProtocols.swift
//  ChuaTeHoiDongQuanTri
//
//  Created by Valerian on 04/04/2022.
//  
//

import Foundation
import UIKit
import SwiftUI

// MARK: -View Output (Presenter -> View)
protocol TikTokScreenViewProtocol : AnyObject {
    
    var presenter : TikTokScreenPresenterProtocol? { get set }

    // PRESENTER -> VIEW
    func showStreaming(data : [TikTokModel])
    func configureView(data : [ReviewMedia])
}


// MARK: -View Input (View -> Presenter)
protocol TikTokScreenPresenterProtocol : AnyObject  {
    
    var view: TikTokScreenViewProtocol? { get set }
    var interactor: TikTokScreenInteractorInputProtocol? { get set }
    var router: TikTokScreenRouterProtocol? { get set }
    
    // VIEW -> PRESENTER
    
    func fetchData(with page : Int)

}

// MARK: -Interactor Input (Presenter -> Interactor)
protocol TikTokScreenInteractorInputProtocol : AnyObject  {

    var presenter: TikTokScreenPresenterOutputProtocol? { get set }
    
    // PRESENTER -> INTERACTOR
    func fetching(with page : Int)
}


// MARK: -Interactor Output (Interactor -> Presenter)
protocol TikTokScreenPresenterOutputProtocol : AnyObject  {
    
    // INTERACTOR -> PRESENTER
    func didFetch(data : [TikTokModel])
    func didGetListReview(data : [ReviewMedia])
}


// MARK: -Router Input (Presenter -> Router)
protocol TikTokScreenRouterProtocol : AnyObject  {
    
    static func createModule() -> UIViewController

    // PRESENTER -> ROUTER
}


