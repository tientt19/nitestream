//
//  ExpandScreenProtocols.swift
//  ChuaTeHoiDongQuanTri
//
//  Created by Valerian on 29/03/2022.
//  
//

import Foundation
import UIKit
import SwiftUI

// MARK: -View Output (Presenter -> View)
protocol ExpandScreenViewProtocol : AnyObject {
    var presenter : ExpandScreenPresenterProtocol? { get set }

    // PRESENTER -> VIEW

}


// MARK: -View Input (View -> Presenter)
protocol ExpandScreenPresenterProtocol : AnyObject  {
    
    var view: ExpandScreenViewProtocol? { get set }
    var interactor: ExpandScreenInteractorInputProtocol? { get set }
    var router: ExpandScreenRouterProtocol? { get set }
    
    // VIEW -> PRESENTER
    func onViewDidLoad()
    func openDetailView(id : Int, category : Int)
}

// MARK: -Interactor Input (Presenter -> Interactor)
protocol ExpandScreenInteractorInputProtocol : AnyObject  {
    // PRESENTER -> INTERACTOR

    var presenter: ExpandScreenPresenterOutputProtocol? { get set }
    func handleGetDetailMovie(id: Int, category: Int)
}


// MARK: -Interactor Output (Interactor -> Presenter)
protocol ExpandScreenPresenterOutputProtocol : AnyObject  {
    // INTERACTOR -> PRESENTER
    
    func didGetMovieDetail(_ data : MovieDetail)
}


// MARK: -Router Input (Presenter -> Router)
protocol ExpandScreenRouterProtocol : AnyObject  {
    static func createModule(with data : RecommendItem) -> UIViewController

    // PRESENTER -> ROUTER
    func openDetailMovie(from view : ExpandScreenViewProtocol, for data : MovieDetail )
}
