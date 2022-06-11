//
//  
//  TVSeriesInteractorInput.swift
//  ChuTeHoiDongQuanTri
//
//  Created by Valerian on 11/06/2022.
//
//

import UIKit

// MARK: - Interactor Input Protocol
protocol TVSeriesInteractorInputProtocol {

}

// MARK: - Interactor Output Protocol
protocol TVSeriesInteractorOutputProtocol: AnyObject {
    
}

// MARK: - TVSeries InteractorInput
class TVSeriesInteractorInput {
    weak var output: TVSeriesInteractorOutputProtocol?
}

// MARK: - TVSeries InteractorInputProtocol
extension TVSeriesInteractorInput: TVSeriesInteractorInputProtocol {

}
