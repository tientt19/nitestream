//
//  
//  SplashScreenInteractorInput.swift
//  ChuTeHoiDongQuanTri
//
//  Created by Valerian on 18/05/2022.
//
//

import UIKit

// MARK: - Interactor Input Protocol
protocol SplashScreenInteractorInputProtocol {

}

// MARK: - Interactor Output Protocol
protocol SplashScreenInteractorOutputProtocol: AnyObject {
    
}

// MARK: - SplashScreen InteractorInput
class SplashScreenInteractorInput {
    weak var output: SplashScreenInteractorOutputProtocol?
}

// MARK: - SplashScreen InteractorInputProtocol
extension SplashScreenInteractorInput: SplashScreenInteractorInputProtocol {

}
