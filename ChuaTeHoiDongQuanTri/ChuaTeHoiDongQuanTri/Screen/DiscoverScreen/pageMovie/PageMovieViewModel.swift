//
//  
//  PageMovieViewModel.swift
//  ChuTeHoiDongQuanTri
//
//  Created by Valerian on 16/04/2022.
//
//

import UIKit

// MARK: - ViewModelProtocol
protocol PageMovieViewModelProtocol {
    func onViewDidLoad()
}

// MARK: - PageMovie ViewModel
class PageMovieViewModel {
    weak var view: PageMovieViewProtocol?
    private var interactor: PageMovieInteractorInputProtocol

    init(interactor: PageMovieInteractorInputProtocol) {
        self.interactor = interactor
    }

}

// MARK: - PageMovie ViewModelProtocol
extension PageMovieViewModel: PageMovieViewModelProtocol {
    func onViewDidLoad() {
        
    }
}

// MARK: - PageMovie InteractorOutputProtocol
extension PageMovieViewModel: PageMovieInteractorOutputProtocol {

}
