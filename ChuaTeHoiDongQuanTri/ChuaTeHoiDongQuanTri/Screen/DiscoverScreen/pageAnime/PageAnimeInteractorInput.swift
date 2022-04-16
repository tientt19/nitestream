//
//  
//  PageAnimeInteractorInput.swift
//  ChuTeHoiDongQuanTri
//
//  Created by Valerian on 16/04/2022.
//
//

import UIKit

// MARK: - Interactor Input Protocol
protocol PageAnimeInteractorInputProtocol {

}

// MARK: - Interactor Output Protocol
protocol PageAnimeInteractorOutputProtocol: AnyObject {
    
}

// MARK: - PageAnime InteractorInput
class PageAnimeInteractorInput {
    weak var output: PageAnimeInteractorOutputProtocol?
}

// MARK: - PageAnime InteractorInputProtocol
extension PageAnimeInteractorInput: PageAnimeInteractorInputProtocol {

}
