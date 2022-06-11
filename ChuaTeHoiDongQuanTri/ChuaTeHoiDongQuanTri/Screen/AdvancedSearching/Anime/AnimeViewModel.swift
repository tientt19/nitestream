//
//  
//  AnimeViewModel.swift
//  ChuTeHoiDongQuanTri
//
//  Created by Valerian on 11/06/2022.
//
//

import UIKit

// MARK: - ViewModelProtocol
protocol AnimeViewModelProtocol {
    func onViewDidLoad()
}

// MARK: - Anime ViewModel
class AnimeViewModel {
    weak var view: AnimeViewProtocol?
    private var interactor: AnimeInteractorInputProtocol

    init(interactor: AnimeInteractorInputProtocol) {
        self.interactor = interactor
    }

}

// MARK: - Anime ViewModelProtocol
extension AnimeViewModel: AnimeViewModelProtocol {
    func onViewDidLoad() {
        
    }
}

// MARK: - Anime InteractorOutputProtocol
extension AnimeViewModel: AnimeInteractorOutputProtocol {

}
