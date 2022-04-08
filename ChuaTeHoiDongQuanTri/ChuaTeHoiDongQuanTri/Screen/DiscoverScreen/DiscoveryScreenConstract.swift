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

}

// MARK: - Presenter
protocol DiscoveryScreenPresenterProtocol {
    func onViewDidLoad()
    
    var numberOfCell: Int { get }
    var numberOfSection: Int { get }
}

// MARK: - Interactor Input
protocol DiscoveryScreenInteractorInputProtocol {

}

// MARK: - Interactor Output
protocol DiscoveryScreenInteractorOutputProtocol: AnyObject {
    
}

// MARK: - Router
protocol DiscoveryScreenRouterProtocol {

}
