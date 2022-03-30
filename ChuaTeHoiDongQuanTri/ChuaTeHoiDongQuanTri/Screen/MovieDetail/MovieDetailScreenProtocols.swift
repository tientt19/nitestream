//
//  MovieDetailScreenProtocols.swift
//  ChuaTeHoiDongQuanTri
//
//  Created by Valerian on 30/03/2022.
//  
//

import Foundation
import UIKit
import SwiftUI

// MARK: -View Output (Presenter -> View)
protocol MovieDetailScreenViewProtocol : AnyObject {
    var presenter : MovieDetailScreenPresenterProtocol? { get set }

    // PRESENTER -> VIEW
}


// MARK: -View Input (View -> Presenter)
protocol MovieDetailScreenPresenterProtocol : AnyObject  {
    
    var view: MovieDetailScreenViewProtocol? { get set }
    var interactor: MovieDetailScreenInteractorInputProtocol? { get set }
    var router: MovieDetailScreenRouterProtocol? { get set }
    
    // VIEW -> PRESENTER
    func handleFetching(_ data : MovieDetail)
}

// MARK: -Interactor Input (Presenter -> Interactor)
protocol MovieDetailScreenInteractorInputProtocol : AnyObject  {

    var presenter: MovieDetailScreenPresenterOutputProtocol? { get set }
    
    // PRESENTER -> INTERACTOR
    func fetchingData(_ data : MovieDetail)
}


// MARK: -Interactor Output (Interactor -> Presenter)
protocol MovieDetailScreenPresenterOutputProtocol : AnyObject  {
    // INTERACTOR -> PRESENTER

}


// MARK: -Router Input (Presenter -> Router)
protocol MovieDetailScreenRouterProtocol : AnyObject  {
    static func createModule() -> UIViewController

    // PRESENTER -> ROUTER
}
