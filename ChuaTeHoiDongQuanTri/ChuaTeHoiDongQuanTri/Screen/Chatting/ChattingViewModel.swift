//
//  
//  ChattingViewModel.swift
//  nitestream
//
//  Created by Valerian on 20/06/2022.
//
//

import UIKit

// MARK: - ViewModelProtocol
protocol ChattingViewModelProtocol {
    func onViewDidLoad()
}

// MARK: - Chatting ViewModel
class ChattingViewModel {
    weak var view: ChattingViewProtocol?
    private var interactor: ChattingInteractorInputProtocol

    init(interactor: ChattingInteractorInputProtocol) {
        self.interactor = interactor
    }

}

// MARK: - Chatting ViewModelProtocol
extension ChattingViewModel: ChattingViewModelProtocol {
    func onViewDidLoad() {
        
    }
}

// MARK: - Chatting InteractorOutputProtocol
extension ChattingViewModel: ChattingInteractorOutputProtocol {

}
