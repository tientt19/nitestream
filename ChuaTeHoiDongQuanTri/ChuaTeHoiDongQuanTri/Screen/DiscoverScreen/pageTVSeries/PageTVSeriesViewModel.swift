//
//  
//  PageTVSeriesViewModel.swift
//  ChuTeHoiDongQuanTri
//
//  Created by Valerian on 16/04/2022.
//
//

import UIKit

// MARK: - ViewModelProtocol
protocol PageTVSeriesViewModelProtocol {
    func onViewDidLoad()
//    func getAdvancedSearchResult(area : String,
//                                 category : String,
//                                 year : String,
//                                 subtitles : String,
//                                 order : String)
    func getAdvancedSearchResult(searchingModel: DiscoverySearchingModel)
    func itemForRow(at index: IndexPath) -> ScreeningItems
    func itemForRow(at index: IndexPath) -> [SearchResult]
    func didSelectedItem(at index: IndexPath)
    
    var numberOfCell: Int { get }
    var numberOListResult: Int { get }
    var numberOfSection: Int { get }
}

// MARK: - PageTVSeries ViewModel
class PageTVSeriesViewModel {
    weak var view: PageTVSeriesViewProtocol?
    private var interactor: PageTVSeriesInteractorInputProtocol
    var screeningItems = [ScreeningItems]() {
        didSet {
            self.view?.reloadData(with: 0)
        }
    }
    var advancedSearchResult = [SearchResult]() {
        didSet {
            self.view?.reloadData(with: 1)
        }
    }

    init(interactor: PageTVSeriesInteractorInputProtocol) {
        self.interactor = interactor
    }
}

// MARK: - PageTVSeries ViewModelProtocol
extension PageTVSeriesViewModel: PageTVSeriesViewModelProtocol {
    
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
        self.view?.presentLockView()
        interactor.fetchData()
    }
    
//    func getAdvancedSearchResult(area: String, category: String, year: String, subtitles: String, order: String) {
//        interactor.fetchSearchResults(searchingModel:
//    }
    func getAdvancedSearchResult(searchingModel: DiscoverySearchingModel) {
        interactor.fetchSearchResults(searchingModel: searchingModel)
    }
}

// MARK: - PageTVSeries InteractorOutputProtocol
extension PageTVSeriesViewModel: PageTVSeriesInteractorOutputProtocol {
    func onDiscoveryModelDidChange(with data: [DiscoveryModel]) {
        let totalData = data[0]
        if let screeningData = totalData.screeningItems {
            self.screeningItems = screeningData

            self.interactor.fetchSearchResults(searchingModel: DiscoverySearchingUtility.share.discoverySearchingModel)
        }
    }
    
    func getData(with data : [SearchResult]) {
        self.advancedSearchResult = data
        print("data nay la: \(data.count)")
    }
}
