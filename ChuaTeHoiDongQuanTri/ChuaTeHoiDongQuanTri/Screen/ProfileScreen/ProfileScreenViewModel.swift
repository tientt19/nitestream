//
//  
//  ProfileScreenViewModel.swift
//  ChuTeHoiDongQuanTri
//
//  Created by Valerian on 19/05/2022.
//
//

import UIKit

// MARK: - ViewModelProtocol
protocol ProfileScreenViewModelProtocol {
    func onViewDidLoad()
}

// MARK: - ProfileScreen ViewModel
class ProfileScreenViewModel {
    weak var view: ProfileScreenViewProtocol?
    private var interactor: ProfileScreenInteractorInputProtocol

    init(interactor: ProfileScreenInteractorInputProtocol) {
        self.interactor = interactor
    }

}

// MARK: - ProfileScreen ViewModelProtocol
extension ProfileScreenViewModel: ProfileScreenViewModelProtocol {
    func onViewDidLoad() {
        
    }
}

// MARK: - ProfileScreen InteractorOutputProtocol
extension ProfileScreenViewModel: ProfileScreenInteractorOutputProtocol {

}
