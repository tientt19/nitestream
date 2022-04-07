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
    func configureDataWhenLoadMore(_ tiktokModel : [TikTokModel],_ reviewData : [ReviewMedia])
}


// MARK: -View Input (View -> Presenter)
protocol TikTokScreenPresenterProtocol : AnyObject  {
    
    var view: TikTokScreenViewProtocol? { get set }
    var interactor: TikTokScreenInteractorInputProtocol? { get set }
    var router: TikTokScreenRouterProtocol? { get set }
    
    // VIEW -> PRESENTER
    
    func fetchData(with page : Int)
    func loadMore(with page : Int)
    func openDetail(with id : String ,and category : Int)
}

// MARK: -Interactor Input (Presenter -> Interactor)
protocol TikTokScreenInteractorInputProtocol : AnyObject  {

    var presenter: TikTokScreenPresenterOutputProtocol? { get set }
    
    // PRESENTER -> INTERACTOR
    func fetching(with page : Int)
    func loadMore(with page : Int)
    func openDetail(with id : String ,and category : Int)
}


// MARK: -Interactor Output (Interactor -> Presenter)
protocol TikTokScreenPresenterOutputProtocol : AnyObject  {
    
    // INTERACTOR -> PRESENTER
    func didFetch(data : [TikTokModel],reviewData : [ReviewMedia])
    func didLoadMore(tiktokModel : [TikTokModel], reviewData : [ReviewMedia])
    func didGetMovieDetail(_ data : MovieDetail)
}


// MARK: -Router Input (Presenter -> Router)
protocol TikTokScreenRouterProtocol : AnyObject  {
    
    static func createModule() -> UIViewController

    // PRESENTER -> ROUTER
    func openDetailView(view : TikTokScreenViewProtocol, data : MovieDetail)
}

//MARK: - TikTokDataSoure
protocol TikTokDataSourceProtocols : TableViewDataSource {
    var reviewData: [ReviewMedia] { get }
    func loadMore(with page : Int)
    func configureWhenLoadMore(tiktokModel : [TikTokModel], reviewData : [ReviewMedia])
}

