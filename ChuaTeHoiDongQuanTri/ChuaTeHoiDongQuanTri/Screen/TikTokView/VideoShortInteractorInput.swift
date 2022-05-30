//
//  
//  VideoShortInteractorInput.swift
//  ChuTeHoiDongQuanTri
//
//  Created by Valerian on 27/05/2022.
//
//

import UIKit

// MARK: - Interactor Input Protocol
protocol VideoShortInteractorInputProtocol {

}

// MARK: - Interactor Output Protocol
protocol VideoShortInteractorOutputProtocol: AnyObject {
    
}

// MARK: - VideoShort InteractorInput
class VideoShortInteractorInput {
    weak var output: VideoShortInteractorOutputProtocol?
}

// MARK: - VideoShort InteractorInputProtocol
extension VideoShortInteractorInput: VideoShortInteractorInputProtocol {

}
