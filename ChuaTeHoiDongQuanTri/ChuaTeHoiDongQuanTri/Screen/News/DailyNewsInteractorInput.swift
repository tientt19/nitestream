//
//  
//  DailyNewsInteractorInput.swift
//  ChuTeHoiDongQuanTri
//
//  Created by Valerian on 31/05/2022.
//
//

import UIKit

// MARK: - Interactor Input Protocol
protocol DailyNewsInteractorInputProtocol {

}

// MARK: - Interactor Output Protocol
protocol DailyNewsInteractorOutputProtocol: AnyObject {
    
}

// MARK: - DailyNews InteractorInput
class DailyNewsInteractorInput {
    weak var output: DailyNewsInteractorOutputProtocol?
}

// MARK: - DailyNews InteractorInputProtocol
extension DailyNewsInteractorInput: DailyNewsInteractorInputProtocol {

}
