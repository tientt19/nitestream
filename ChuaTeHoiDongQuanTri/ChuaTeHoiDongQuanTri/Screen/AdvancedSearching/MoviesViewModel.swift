//
//  
//  MoviesViewModel.swift
//  ChuTeHoiDongQuanTri
//
//  Created by Valerian on 11/06/2022.
//
//

import UIKit

// MARK: - ViewModelProtocol
protocol MoviesViewModelProtocol {
    func onViewDidLoad()
}

// MARK: - Movies ViewModel
class MoviesViewModel {
    weak var view: MoviesViewProtocol?
    private var interactor: MoviesInteractorInputProtocol

    init(interactor: MoviesInteractorInputProtocol) {
        self.interactor = interactor
    }

}

// MARK: - Movies ViewModelProtocol
extension MoviesViewModel: MoviesViewModelProtocol {
    func onViewDidLoad() {
        
    }
}

// MARK: - Movies InteractorOutputProtocol
extension MoviesViewModel: MoviesInteractorOutputProtocol {

}
