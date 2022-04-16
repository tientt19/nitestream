//
//  SearchingViewProtocols.swift
//  ChuaTeHoiDongQuanTri
//
//  Created by Valerian on 28/03/2022.
//

import Foundation
import UIKit
import SwiftUI

protocol SearchingViewProtocols : AnyObject {
    var presenter : SearchingPresenterProtocols? { get set }
    
    // PRESENTER -> VIEW
    func reloadTableView(tableViewDataSource : TableViewDataSource)
    func reloadSearchingTableView(_ data : [String])
}

protocol SearchingPresenterProtocols : AnyObject {
    var view: SearchingViewProtocols? { get set }
    var interactor: SearchingInteratorInputProtocols? { get set }
    var router: SearchingRouterProtocols? { get set }
    
    // VIEW -> PRESENTER
    func callToGetTopSearchingData()
    func handleSearchWithKeywork(_ keyword : String)
    func getListSearch(_ keyword : String)
    func openDetailView(id : String, category : Int)
}

protocol SearchingInteratorInputProtocols : AnyObject {
    var presenter : SearchingInteractorOutputProtocols? { get set }
    
    // PRESENTER -> INTERACTOR
    func handleGetData()
    func handleGetListSearch(_ keyword : String)
    func handleGetDetailMovie(id : String, category : Int)
    func handleSearchWithKeyword(keyword : String)
}

protocol SearchingInteractorOutputProtocols : AnyObject {
    // INTERACTOR -> PRESENTER
    
    func didGetData(_ data : [TopSearchData])
    func didGetMovieDetail(_ data : MovieDetail)
    func didGetDataSearch(_ data :  [String])
    func didGetListSearch(_ data : [TopSearchData])
}

protocol SearchingRouterProtocols : AnyObject {
    static func createSearchingModule() -> UIViewController
    // PRESENTER -> ROUTER
    
    func openDetailMovie(from view : SearchingViewProtocols, for data : MovieDetail )
}

protocol TableViewDataSource : AnyObject {
    var numberOfItems: Int { get }
    func itemCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell
    func didSelect(tableView: UITableView, indexPath: IndexPath)
}
