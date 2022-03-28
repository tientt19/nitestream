//
//  SearchingViewProtocols.swift
//  ChuaTeHoiDongQuanTri
//
//  Created by Valerian on 28/03/2022.
//

import Foundation
import UIKit

protocol SearchingViewProtocols : AnyObject {
    var presenter : SearchingPresenterProtocols? { get set }
    
    // PRESENTER -> VIEW
    
    
}

protocol SearchingPresenterProtocols : AnyObject {
    var view: SearchingViewProtocols? { get set }
    var interactor: SearchingInteratorInputProtocols? { get set }
    var router: SearchingRouterProtocols? { get set }
    
    // VIEW -> PRESENTER
    
    
}

protocol SearchingInteratorInputProtocols : AnyObject {
    var presenter : SearchingInteractorOutputProtocols? { get set }
    // PRESENTER -> INTERACTOR
    
    
}

protocol SearchingInteractorOutputProtocols : AnyObject {
    // INTERACTOR -> PRESENTER
    
    
}

protocol SearchingRouterProtocols : AnyObject {
    static func createSearchingModule() -> UIViewController
    // PRESENTER -> ROUTER
    
    
    
}
