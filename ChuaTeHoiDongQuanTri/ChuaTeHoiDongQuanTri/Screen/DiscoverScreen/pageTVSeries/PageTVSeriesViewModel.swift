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
    func itemForRow(at index: IndexPath) -> ScreeningItems
    func didSelectedItem(at index: IndexPath)
    
    var numberOfCell: Int { get }
    var numberOfSection: Int { get }
}

// MARK: - PageTVSeries ViewModel
class PageTVSeriesViewModel {
    weak var view: PageTVSeriesViewProtocol?
    private var interactor: PageTVSeriesInteractorInputProtocol
    var screeningItems = [ScreeningItems]()

    init(interactor: PageTVSeriesInteractorInputProtocol) {
        self.interactor = interactor
    }

}

// MARK: - PageTVSeries ViewModelProtocol
extension PageTVSeriesViewModel: PageTVSeriesViewModelProtocol {

    func itemForRow(at index: IndexPath) -> ScreeningItems {
        if self.screeningItems.isEmpty {
            return ScreeningItems(id: 0, item: [], name: "", disc: .type)
        }
        return self.screeningItems[index.row]
    }
    
    
    func didSelectedItem(at index: IndexPath) {
        
    }
    
    var numberOfCell: Int {
        return 5
    }
    
    var numberOfSection: Int {
        return 1
    }
    
    func onViewDidLoad() {
        interactor.fetchData()
    }
    
}

// MARK: - PageTVSeries InteractorOutputProtocol
extension PageTVSeriesViewModel: PageTVSeriesInteractorOutputProtocol {
    func onDiscoveryModelDidChange(with data: [DiscoveryModel]) {
        let totalData = data[0]
        if let screeningData = totalData.screeningItems {
            self.screeningItems = screeningData
            self.view?.reloadData()
        }
    }
}
