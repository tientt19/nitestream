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
    func fetchSearchResults()
}

// MARK: - Interactor Output Protocol
protocol PageTVSeriesInteractorOutputProtocol: AnyObject {
    func onDiscoveryModelDidChange(with data: [DiscoveryModel])
    func getData(with data : [SearchResult])
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
    
    private func getSearchResult() {
        APIService.shared.getAdvancedSearching(params: "TV,SETI,MINISERIES,VARIETY,TALK,COMIC,DOCUMENTARY", area: "", category: "", year: "", subtitles: "") { [weak self] response, error in
            guard let `self` = self, let unwrappedData = response else { return }
            self.output?.getData(with: unwrappedData)
        }
    }
}

// MARK: - PageTVSeries InteractorInputProtocol
extension PageTVSeriesInteractorInput: PageTVSeriesInteractorInputProtocol {
    func fetchData() {
        self.fetchDiscoveryData()
    }
    
    func fetchSearchResults() {
        self.getSearchResult()
    }
}
