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
    func playMedia(link : LinkMedia)
}


// MARK: -View Input (View -> Presenter)
protocol MovieDetailScreenPresenterProtocol : AnyObject  {
    
    var view: MovieDetailScreenViewProtocol? { get set }
    var interactor: MovieDetailScreenInteractorInputProtocol? { get set }
    var router: MovieDetailScreenRouterProtocol? { get set }
    
    // VIEW -> PRESENTER
    func loadLinkMedia(_ contentID : String, _ category : Int, _ episodeID : Int, _ definition : String)
}

// MARK: -Interactor Input (Presenter -> Interactor)
protocol MovieDetailScreenInteractorInputProtocol : AnyObject  {

    var presenter: MovieDetailScreenPresenterOutputProtocol? { get set }
    
    // PRESENTER -> INTERACTOR
    func loadMedia(_ contentID : String, _ category : Int, _ episodeID : Int, _ definition : String)
}


// MARK: -Interactor Output (Interactor -> Presenter)
protocol MovieDetailScreenPresenterOutputProtocol : AnyObject  {
    // INTERACTOR -> PRESENTER
    func didGetLinkMedia(link : LinkMedia)
}


// MARK: -Router Input (Presenter -> Router)
protocol MovieDetailScreenRouterProtocol : AnyObject  {
    static func createModule(_ data : MovieDetail) -> UIViewController

    // PRESENTER -> ROUTER
}

//MARK: - Movie detail datasource

protocol DetailDataSource : AnyObject {
    var sections : [Section] { get }
    var episodeVo : [EpisodeVo] { get }
    var subRemoteURL : String { get }
    var contentHeight : Int { get }
    
    func itemCell(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell
    func didSelect(collectionView: UICollectionView, indexPath: IndexPath)
    func sizeForItem(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    func prefetchingData(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath])
    func configureHeader(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView
    func getContentHeight() -> CGFloat
    func getLinkSub(_ seriesNo: Int) -> String
}
