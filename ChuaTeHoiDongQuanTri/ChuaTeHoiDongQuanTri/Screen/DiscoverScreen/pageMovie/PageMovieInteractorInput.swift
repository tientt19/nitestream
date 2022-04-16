//
//  
//  PageMovieInteractorInput.swift
//  ChuTeHoiDongQuanTri
//
//  Created by Valerian on 16/04/2022.
//
//

import UIKit

// MARK: - Interactor Input Protocol
protocol PageMovieInteractorInputProtocol {

}

// MARK: - Interactor Output Protocol
protocol PageMovieInteractorOutputProtocol: AnyObject {
    
}

// MARK: - PageMovie InteractorInput
class PageMovieInteractorInput {
    weak var output: PageMovieInteractorOutputProtocol?
}

// MARK: - PageMovie InteractorInputProtocol
extension PageMovieInteractorInput: PageMovieInteractorInputProtocol {

}
