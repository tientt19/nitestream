//
//  
//  TMBDHomeInteractorInput.swift
//  nitestream
//
//  Created by Valerian on 18/07/2022.
//
//

import UIKit

// MARK: - Interactor Input Protocol
protocol TMBDHomeInteractorInputProtocol {

}

// MARK: - Interactor Output Protocol
protocol TMBDHomeInteractorOutputProtocol: AnyObject {
    
}

// MARK: - TMBDHome InteractorInput
class TMBDHomeInteractorInput {
    weak var output: TMBDHomeInteractorOutputProtocol?
}

// MARK: - TMBDHome InteractorInputProtocol
extension TMBDHomeInteractorInput: TMBDHomeInteractorInputProtocol {

}
