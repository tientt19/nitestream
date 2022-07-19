//
//  
//  TMBDHomeViewModel.swift
//  nitestream
//
//  Created by Valerian on 18/07/2022.
//
//

import UIKit

// MARK: - ViewModelProtocol
protocol TMBDHomeViewModelProtocol {
    func onViewDidLoad()
    //func onViewDidAppear()
    
    // UITableView
    //func numberOfSections() -> Int
    //func numberOfRows() -> Int
    //func cellForRow(at indexPath: IndexPath) -> Any?
    //func didSelectRow(at indexPath: IndexPath)
    
    // UICollectionView
    //func numberOfItems() -> Int
    //func cellForItem(at indexPath: IndexPath) -> Any
    //func didSelectItem(at indexPath: IndexPath)
}

// MARK: - TMBDHome ViewModel
class TMBDHomeViewModel {
    weak var view: TMBDHomeViewProtocol?
    private var interactor: TMBDHomeInteractorInputProtocol

    init(interactor: TMBDHomeInteractorInputProtocol) {
        self.interactor = interactor
    }

}

// MARK: - TMBDHome ViewModelProtocol
extension TMBDHomeViewModel: TMBDHomeViewModelProtocol {
    func onViewDidLoad() {
        
    }
}

// MARK: - TMBDHome InteractorOutputProtocol
extension TMBDHomeViewModel: TMBDHomeInteractorOutputProtocol {

}
