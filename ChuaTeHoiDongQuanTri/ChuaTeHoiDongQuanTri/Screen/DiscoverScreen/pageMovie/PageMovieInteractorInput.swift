//
//  
//  PageMovieInteractorInput.swift
//  ChuTeHoiDongQuanTri
//
//  Created by Valerian on 16/04/2022.
//
//

import UIKit

// MARK: - Interactor Input Protocol
protocol PageMovieInteractorInputProtocol {
    func fetchData()
    func fetchSearchResults()
}

// MARK: - Interactor Output Protocol
protocol PageMovieInteractorOutputProtocol: AnyObject {
    func onDiscoveryModelDidChange(with data: [DiscoveryModel])
    func getData(with data : [SearchResult])
}

// MARK: - PageMovie InteractorInput
class PageMovieInteractorInput {
    weak var output: PageMovieInteractorOutputProtocol?
    
    private func fetchDiscoveryData() {
        APIService.shared.getDiscoveryItem { [weak self] response, error in
            guard let `self` = self, let unwrappedData = response else { return }
            self.output?.onDiscoveryModelDidChange(with: unwrappedData)
        }
    }
    
    private func getSearchResult() {
        APIService.shared.getAdvancedSearching(params: DiscoveryParams.Movie.params, area: "", category: "", year: "", subtitles: "") { [weak self] response, error in
            guard let `self` = self, let unwrappedData = response else { return }
            self.output?.getData(with: unwrappedData)
        }
    }
}

// MARK: - PageMovie InteractorInputProtocol
extension PageMovieInteractorInput: PageMovieInteractorInputProtocol {
    func fetchData() {
        self.fetchDiscoveryData()
    }
    
    func fetchSearchResults() {
        self.getSearchResult()
    }
}
