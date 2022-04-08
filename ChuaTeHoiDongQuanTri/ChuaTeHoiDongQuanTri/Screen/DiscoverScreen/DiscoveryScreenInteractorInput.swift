//
//  
//  DiscoveryScreenInteractorInput.swift
//  ChuTeHoiDongQuanTri
//
//  Created by admin on 05/04/2022.
//
//

import UIKit

class DiscoveryScreenInteractorInput {
    weak var output: DiscoveryScreenInteractorOutputProtocol?

    private func fetchDiscoveryData() {
        APIService.shared.getDiscoveryItem { [weak self] response, error in
            guard let `self` = self, let unwrappedData = response else { return }
            self.output?.onDiscoveryModelDidChange(with: unwrappedData)
        }
    }
}

// MARK: - DiscoveryScreenInteractorInputProtocol
extension DiscoveryScreenInteractorInput: DiscoveryScreenInteractorInputProtocol {
    func fetchData() {
        self.fetchDiscoveryData()
    }
}
