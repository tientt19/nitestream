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

    var screeningItems = [ScreeningItems]()
    
    init(interactor: DiscoveryScreenInteractorInputProtocol,
         router: DiscoveryScreenRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
    
    private func filterScreeningData(with type: DiscoveryType, and data: [ScreeningItems]) -> [ScreeningItems] {
        var filterData = [ScreeningItems]()
        if let filterItem = data.first(where: { $0.discoveryType == type}) {
            filterData.append(filterItem)
        }
        return filterData
    }

}

// MARK: - DiscoveryScreenPresenterProtocol
extension DiscoveryScreenPresenter: DiscoveryScreenPresenterProtocol {
    func onViewDidLoad() {
//        interactor.fetchData()
    }
}

// MARK: - DiscoveryScreenInteractorOutput 
extension DiscoveryScreenPresenter: DiscoveryScreenInteractorOutputProtocol {

}
