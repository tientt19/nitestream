//
//  
//  PageAnimeViewModel.swift
//  ChuTeHoiDongQuanTri
//
//  Created by Valerian on 16/04/2022.
//
//

import UIKit

// MARK: - ViewModelProtocol
protocol PageAnimeViewModelProtocol {
    func onViewDidLoad()
    func getAdvancedSearchResult()
    func itemForRow(at index: IndexPath) -> ScreeningItems
    func itemForRow(at index: IndexPath) -> [SearchResult]
    func didSelectedItem(at index: IndexPath)
    
    var numberOfCell: Int { get }
    var numberOListResult: Int { get }
    var numberOfSection: Int { get }
}

// MARK: - PageAnime ViewModel
class PageAnimeViewModel {
    weak var view: PageAnimeViewProtocol?
    private var interactor: PageAnimeInteractorInputProtocol
    var screeningItems = [ScreeningItems]()
    var advancedSearchResult = [SearchResult]()
    
    init(interactor: PageAnimeInteractorInputProtocol) {
        self.interactor = interactor
    }

}

// MARK: - PageTVSeries ViewModelProtocol
extension PageAnimeViewModel: PageAnimeViewModelProtocol {
    func itemForRow(at index: IndexPath) -> [SearchResult] {
        if self.advancedSearchResult.isEmpty {
            return [SearchResult]()
        }
        return self.advancedSearchResult
    }
    
    func itemForRow(at index: IndexPath) -> ScreeningItems {
        if self.screeningItems.isEmpty {
            return ScreeningItems(id: 0, item: [], name: "", disc: .type)
        }
        return self.screeningItems[index.row]
    }
    
    func didSelectedItem(at index: IndexPath) {
        
    }
    
    var numberOListResult: Int {
        return 1
    }

    var numberOfCell: Int {
        return 5
    }
    
    var numberOfSection: Int {
        return 2
    }
    
    func onViewDidLoad() {
        interactor.fetchData()
    }
    
    func getAdvancedSearchResult() {
        interactor.fetchSearchResults()
    }
}
// MARK: - PageAnime InteractorOutputProtocol
extension PageAnimeViewModel: PageAnimeInteractorOutputProtocol {
    func onDiscoveryModelDidChange(with data: [DiscoveryModel]) {
        let totalData = data[2]
        if let screeningData = totalData.screeningItems {
            self.screeningItems = screeningData
        }
    }
    
    func getData(with data : [SearchResult]) {
        self.advancedSearchResult = data
        self.view?.reloadData()
    }

}
