//
//  
//  TVSeriesViewModel.swift
//  ChuTeHoiDongQuanTri
//
//  Created by Valerian on 11/06/2022.
//
//

import UIKit

// MARK: - ViewModelProtocol
protocol TVSeriesViewModelProtocol {
    func onViewDidLoad()
}

// MARK: - TVSeries ViewModel
class TVSeriesViewModel {
    weak var view: TVSeriesViewProtocol?
    private var interactor: TVSeriesInteractorInputProtocol

    init(interactor: TVSeriesInteractorInputProtocol) {
        self.interactor = interactor
    }

}

// MARK: - TVSeries ViewModelProtocol
extension TVSeriesViewModel: TVSeriesViewModelProtocol {
    func onViewDidLoad() {
        
    }
}

// MARK: - TVSeries InteractorOutputProtocol
extension TVSeriesViewModel: TVSeriesInteractorOutputProtocol {

}
