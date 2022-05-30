//
//  
//  VideoShortViewModel.swift
//  ChuTeHoiDongQuanTri
//
//  Created by Valerian on 27/05/2022.
//
//

import UIKit

// MARK: - ViewModelProtocol
protocol VideoShortViewModelProtocol {
    func onViewDidLoad()
}

// MARK: - VideoShort ViewModel
class VideoShortViewModel {
    weak var view: VideoShortViewProtocol?
    private var interactor: VideoShortInteractorInputProtocol

    init(interactor: VideoShortInteractorInputProtocol) {
        self.interactor = interactor
    }

}

// MARK: - VideoShort ViewModelProtocol
extension VideoShortViewModel: VideoShortViewModelProtocol {
    func onViewDidLoad() {
        
    }
}

// MARK: - VideoShort InteractorOutputProtocol
extension VideoShortViewModel: VideoShortInteractorOutputProtocol {

}
