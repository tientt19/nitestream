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
    func fetchSearchResults(area : String,
                            category : String,
                            year : String,
                            subtitles : String,
                            order : String)
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
    
    private func getSearchResult(area : String,
                                 category : String,
                                 year : String,
                                 subtitles : String,
                                 order : String) {
        APIService.shared.getAdvancedSearching(params: DiscoveryParams.TVSeries.rawValue, area: area, category: category, year: year, subtitles: subtitles, order: order) { [weak self] response, error in
            guard let `self` = self, let unwrappedData = response else { return }
            self.output?.getData(with: unwrappedData)
        }
    }
}

// MARK: - PageTVSeries InteractorInputProtocol
extension PageTVSeriesInteractorInput: PageTVSeriesInteractorInputProtocol {
    func fetchSearchResults(area: String, category: String, year: String, subtitles: String, order: String) {
        self.getSearchResult(area: area, category: category, year: year, subtitles: subtitles, order: order)
    }
    
    func fetchData() {
        self.fetchDiscoveryData()
    }
}
