//
//  
//  AnimeInteractorInput.swift
//  ChuTeHoiDongQuanTri
//
//  Created by Valerian on 11/06/2022.
//
//

import UIKit

// MARK: - Interactor Input Protocol
protocol AnimeInteractorInputProtocol {

}

// MARK: - Interactor Output Protocol
protocol AnimeInteractorOutputProtocol: AnyObject {
    
}

// MARK: - Anime InteractorInput
class AnimeInteractorInput {
    weak var output: AnimeInteractorOutputProtocol?
}

// MARK: - Anime InteractorInputProtocol
extension AnimeInteractorInput: AnimeInteractorInputProtocol {

}
