//
//  
//  PageAnimeInteractorInput.swift
//  ChuTeHoiDongQuanTri
//
//  Created by Valerian on 16/04/2022.
//
//

import UIKit

// MARK: - Interactor Input Protocol
protocol PageAnimeInteractorInputProtocol {
    func fetchData()
    func fetchSearchResults()
}

// MARK: - Interactor Output Protocol
protocol PageAnimeInteractorOutputProtocol: AnyObject {
    func onDiscoveryModelDidChange(with data: [DiscoveryModel])
    func getData(with data : [SearchResult])
}

// MARK: - PageAnime InteractorInput
class PageAnimeInteractorInput {
    weak var output: PageAnimeInteractorOutputProtocol?
    
    private func fetchDiscoveryData() {
        APIService.shared.getDiscoveryItem { [weak self] response, error in
            guard let `self` = self, let unwrappedData = response else { return }
            self.output?.onDiscoveryModelDidChange(with: unwrappedData)
        }
    }
    
    private func getSearchResult() {
        APIService.shared.getAdvancedSearching(params: DiscoveryParams.Anime.params, area: "", category: "", year: "", subtitles: "") { [weak self] response, error in
            guard let `self` = self, let unwrappedData = response else { return }
            self.output?.getData(with: unwrappedData)
        }
    }
}

// MARK: - PageAnime InteractorInputProtocol
extension PageAnimeInteractorInput: PageAnimeInteractorInputProtocol {
    func fetchData() {
        self.fetchDiscoveryData()
    }
    
    func fetchSearchResults() {
        self.getSearchResult()
    }
}
