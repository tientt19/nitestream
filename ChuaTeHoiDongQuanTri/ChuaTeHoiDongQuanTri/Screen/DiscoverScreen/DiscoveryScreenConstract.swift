//
//  
//  DiscoveryScreenConstract.swift
//  ChuTeHoiDongQuanTri
//
//  Created by admin on 05/04/2022.
//
//

import UIKit

// MARK: - View
protocol DiscoveryScreenViewProtocol: AnyObject {
    func reloadData()
    

}

// MARK: - Presenter
protocol DiscoveryScreenPresenterProtocol {
    func onViewDidLoad()
    func itemForRow(at index: IndexPath) -> ScreeningItems
    func didSelectedItem(at index: IndexPath)
    
    var numberOfCell: Int { get }
    var numberOfSection: Int { get }
    
    
}

// MARK: - Interactor Input
protocol DiscoveryScreenInteractorInputProtocol {
    func fetchData()
}

// MARK: - Interactor Output
protocol DiscoveryScreenInteractorOutputProtocol: AnyObject {

    func onDiscoveryModelDidChange(with data: [DiscoveryModel])
}

// MARK: - Router
protocol DiscoveryScreenRouterProtocol {

}
