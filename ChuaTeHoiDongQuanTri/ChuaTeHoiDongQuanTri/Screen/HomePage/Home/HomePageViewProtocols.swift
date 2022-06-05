//
//  HomePageViewProtocols.swift
//  ChuaTeHoiDongQuanTri
//
//  Created by Valerian on 01/04/2022.
//  
//

import Foundation
import UIKit
import SwiftUI

// MARK: -View Output (Presenter -> View)
protocol HomePageViewViewProtocol : AnyObject {
    
    var presenter : HomePageViewPresenterProtocol? { get set }

    // PRESENTER -> VIEW
    func lockView()
    func didGetAlbumsDetailFinish(with list: HomeAlbumsDetailModels)
    func didGetHomePageFinish(with albums: HomePageModels, listBanners: [HomeBannerModels])
}


// MARK: -View Input (View -> Presenter)
protocol HomePageViewPresenterProtocol : AnyObject  {
    
    var view: HomePageViewViewProtocol? { get set }
    var interactor: HomePageViewInteractorInputProtocol? { get set }
    var router: HomePageViewRouterProtocol? { get set }
    
    // VIEW -> PRESENTER
    func onGetMovieDetail(_ id : Int, _ category : Int)
    func openExpandView(with data: HomeAlbumsDetailModels)
    func onGetHomeAlbums(with page: Int)
    func onGetAlbumsDetail(with refID: Int, loadOn page: Int)
}

// MARK: -Interactor Input (Presenter -> Interactor)
protocol HomePageViewInteractorInputProtocol : AnyObject  {

    var presenter: HomePageViewPresenterOutputProtocol? { get set }
    
    // PRESENTER -> INTERACTOR
    func getMovieDetail(_ id : Int, _ category : Int)
    func onGetHomeAlbums(with page: Int)
    func onGetHomeBanner()
    func onGetAlbumsDetail(with refID: Int, loadOn page: Int)
}


// MARK: -Interactor Output (Interactor -> Presenter)
protocol HomePageViewPresenterOutputProtocol : AnyObject  {
    // INTERACTOR -> PRESENTER
    func didGetMovieDetail(_ data : MovieDetail)
    func didGetHomePageAlbumsFinish(with result: Result<HomePageModels, APIError>)
    func didGetHomeBannerFinish(with result: Result<[HomeBannerModels], APIError>)
    func didGetAlbumsDetailFinish(with result: Result<HomeAlbumsDetailModels, APIError>)
}

// MARK: -Router Input (Presenter -> Router)
protocol HomePageViewRouterProtocol : AnyObject  {
    static func createModule() -> UIViewController

    // PRESENTER -> ROUTER
    func openDetailView(view : HomePageViewViewProtocol, data : MovieDetail)
    func openExpandView(from view: HomePageViewViewProtocol, with data: HomeAlbumsDetailModels)
}

