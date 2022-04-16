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
}

// MARK: - PageAnime ViewModel
class PageAnimeViewModel {
    weak var view: PageAnimeViewProtocol?
    private var interactor: PageAnimeInteractorInputProtocol

    init(interactor: PageAnimeInteractorInputProtocol) {
        self.interactor = interactor
    }

}

// MARK: - PageAnime ViewModelProtocol
extension PageAnimeViewModel: PageAnimeViewModelProtocol {
    func onViewDidLoad() {
        
    }
}

// MARK: - PageAnime InteractorOutputProtocol
extension PageAnimeViewModel: PageAnimeInteractorOutputProtocol {

}
