//
//  
//  SearchingIGListKitScreenViewModel.swift
//  ChuTeHoiDongQuanTri
//
//  Created by Valerian on 05/05/2022.
//
//

import UIKit

// MARK: - ViewModelProtocol
protocol SearchingIGListKitScreenViewModelProtocol {
    func onViewDidLoad()
}

// MARK: - SearchingIGListKitScreen ViewModel
class SearchingIGListKitScreenViewModel {
    weak var view: SearchingIGListKitScreenViewProtocol?
    private var interactor: SearchingIGListKitScreenInteractorInputProtocol

    init(interactor: SearchingIGListKitScreenInteractorInputProtocol) {
        self.interactor = interactor
    }

}

// MARK: - SearchingIGListKitScreen ViewModelProtocol
extension SearchingIGListKitScreenViewModel: SearchingIGListKitScreenViewModelProtocol {
    func onViewDidLoad() {
        self.interactor.onHandleGetData()
    }
}

// MARK: - SearchingIGListKitScreen InteractorOutputProtocol
extension SearchingIGListKitScreenViewModel: SearchingIGListKitScreenInteractorOutputProtocol {
    func onHandleGetDataFinish(with data: [TopSearchData]) {
        self.view?.onUpdateData(with: data)
    }
}
