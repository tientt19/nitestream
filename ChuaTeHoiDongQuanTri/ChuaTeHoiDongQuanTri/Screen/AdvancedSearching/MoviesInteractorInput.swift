//
//  
//  MoviesInteractorInput.swift
//  ChuTeHoiDongQuanTri
//
//  Created by Valerian on 11/06/2022.
//
//

import UIKit

// MARK: - Interactor Input Protocol
protocol MoviesInteractorInputProtocol {

}

// MARK: - Interactor Output Protocol
protocol MoviesInteractorOutputProtocol: AnyObject {
    
}

// MARK: - Movies InteractorInput
class MoviesInteractorInput {
    weak var output: MoviesInteractorOutputProtocol?
}

// MARK: - Movies InteractorInputProtocol
extension MoviesInteractorInput: MoviesInteractorInputProtocol {

}
