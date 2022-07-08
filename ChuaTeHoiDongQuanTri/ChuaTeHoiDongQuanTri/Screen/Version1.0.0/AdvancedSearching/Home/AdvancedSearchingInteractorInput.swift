//
//  
//  AdvancedSearchingInteractorInput.swift
//  ChuTeHoiDongQuanTri
//
//  Created by Valerian on 11/06/2022.
//
//

import UIKit

// MARK: - Interactor Input Protocol
protocol AdvancedSearchingInteractorInputProtocol {

}

// MARK: - Interactor Output Protocol
protocol AdvancedSearchingInteractorOutputProtocol: AnyObject {
    
}

// MARK: - AdvancedSearching InteractorInput
class AdvancedSearchingInteractorInput {
    weak var output: AdvancedSearchingInteractorOutputProtocol?
}

// MARK: - AdvancedSearching InteractorInputProtocol
extension AdvancedSearchingInteractorInput: AdvancedSearchingInteractorInputProtocol {

}
