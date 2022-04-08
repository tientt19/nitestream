//
//  
//  DiscoveryScreenPresenter.swift
//  ChuTeHoiDongQuanTri
//
//  Created by admin on 05/04/2022.
//
//

import UIKit

class DiscoveryScreenPresenter {

    weak var view: DiscoveryScreenViewProtocol?
    private var interactor: DiscoveryScreenInteractorInputProtocol
    private var router: DiscoveryScreenRouterProtocol

    init(interactor: DiscoveryScreenInteractorInputProtocol,
         router: DiscoveryScreenRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }

}

// MARK: - DiscoveryScreenPresenterProtocol
extension DiscoveryScreenPresenter: DiscoveryScreenPresenterProtocol {
    var numberOfCell: Int {
        return 1
    }
    
    var numberOfSection: Int {
        return 5
    }
    
    func onViewDidLoad() {
        
    }
}

// MARK: - DiscoveryScreenInteractorOutput 
extension DiscoveryScreenPresenter: DiscoveryScreenInteractorOutputProtocol {

}
