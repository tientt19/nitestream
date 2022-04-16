//
//  
//  PageTVSeriesInteractorInput.swift
//  ChuTeHoiDongQuanTri
//
//  Created by Valerian on 16/04/2022.
//
//

import UIKit

// MARK: - Interactor Input Protocol
protocol PageTVSeriesInteractorInputProtocol {
    func fetchData()

}

// MARK: - Interactor Output Protocol
protocol PageTVSeriesInteractorOutputProtocol: AnyObject {
    func onDiscoveryModelDidChange(with data: [DiscoveryModel])
}

// MARK: - PageTVSeries InteractorInput
class PageTVSeriesInteractorInput {
    weak var output: PageTVSeriesInteractorOutputProtocol?
    
    private func fetchDiscoveryData() {
        APIService.shared.getDiscoveryItem { [weak self] response, error in
            guard let `self` = self, let unwrappedData = response else { return }
            self.output?.onDiscoveryModelDidChange(with: unwrappedData)
        }
    }
}

// MARK: - PageTVSeries InteractorInputProtocol
extension PageTVSeriesInteractorInput: PageTVSeriesInteractorInputProtocol {
    func fetchData() {
        self.fetchDiscoveryData()
    }
}
