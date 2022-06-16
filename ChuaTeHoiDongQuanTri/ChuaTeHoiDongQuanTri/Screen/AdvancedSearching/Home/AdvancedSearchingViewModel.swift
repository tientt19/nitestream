//
//  
//  AdvancedSearchingViewModel.swift
//  ChuTeHoiDongQuanTri
//
//  Created by Valerian on 11/06/2022.
//
//

import UIKit

// MARK: - ViewModelProtocol
protocol AdvancedSearchingViewModelProtocol {
    func onViewDidLoad()
}

// MARK: - AdvancedSearching ViewModel
class AdvancedSearchingViewModel {
    weak var view: AdvancedSearchingViewProtocol?
    private var interactor: AdvancedSearchingInteractorInputProtocol

    init(interactor: AdvancedSearchingInteractorInputProtocol) {
        self.interactor = interactor
    }

}

// MARK: - AdvancedSearching ViewModelProtocol
extension AdvancedSearchingViewModel: AdvancedSearchingViewModelProtocol {
    func onViewDidLoad() {
        
    }
}

// MARK: - AdvancedSearching InteractorOutputProtocol
extension AdvancedSearchingViewModel: AdvancedSearchingInteractorOutputProtocol {

}
