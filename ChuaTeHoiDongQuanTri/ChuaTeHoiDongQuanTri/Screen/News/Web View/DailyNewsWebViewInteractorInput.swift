//
//  
//  DailyNewsWebViewInteractorInput.swift
//  ChuTeHoiDongQuanTri
//
//  Created by Valerian on 04/06/2022.
//
//

import UIKit

// MARK: - Interactor Input Protocol
protocol DailyNewsWebViewInteractorInputProtocol {

}

// MARK: - Interactor Output Protocol
protocol DailyNewsWebViewInteractorOutputProtocol: AnyObject {
    
}

// MARK: - DailyNewsWebView InteractorInput
class DailyNewsWebViewInteractorInput {
    weak var output: DailyNewsWebViewInteractorOutputProtocol?
}

// MARK: - DailyNewsWebView InteractorInputProtocol
extension DailyNewsWebViewInteractorInput: DailyNewsWebViewInteractorInputProtocol {

}
