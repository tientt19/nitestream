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
    func reloadData(_ data : HomePageModel)
}


// MARK: -View Input (View -> Presenter)
protocol HomePageViewPresenterProtocol : AnyObject  {
    
    var view: HomePageViewViewProtocol? { get set }
    var interactor: HomePageViewInteractorInputProtocol? { get set }
    var router: HomePageViewRouterProtocol? { get set }
    
    // VIEW -> PRESENTER
    func getHomePageData(_ page : Int)
    func loadMore(_ page : Int, _ oldDAO : HomePageModel)
}

// MARK: -Interactor Input (Presenter -> Interactor)
protocol HomePageViewInteractorInputProtocol : AnyObject  {

    var presenter: HomePageViewPresenterOutputProtocol? { get set }
    
    // PRESENTER -> INTERACTOR
    func getHomeData(_ page : Int)
    func getMovieDetail(_ id : Int, _ category : Int)
    func loadMore(_ page : Int, _ oldDAO : HomePageModel)
}


// MARK: -Interactor Output (Interactor -> Presenter)
protocol HomePageViewPresenterOutputProtocol : AnyObject  {
    // INTERACTOR -> PRESENTER
    func didGetHomeData(_ data : HomePageModel)
    func didGetMovieDetail(_ data : MovieDetail)
    func didLoad(_ data : HomePageModel)
}

// MARK: -Router Input (Presenter -> Router)
protocol HomePageViewRouterProtocol : AnyObject  {
    static func createModule() -> UIViewController

    // PRESENTER -> ROUTER
    func openDetailView(view : HomePageViewViewProtocol, data : MovieDetail)
}

//MARK: - HomePageViewDataSource
protocol HomePageViewDataSourceProtocol : AnyObject {
    var numberOfItems: Int { get }
    
    func listData() -> HomePageModel
    func loadMore(_ page : Int)
    func itemCell(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell
    func didSelect(collectionView: UICollectionView, indexPath: IndexPath)
    func prefetchingData(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath])
    func itemHeaderCell(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView
}

