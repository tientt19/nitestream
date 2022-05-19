//
//  
//  ProfileScreenInteractorInput.swift
//  ChuTeHoiDongQuanTri
//
//  Created by Valerian on 19/05/2022.
//
//

import UIKit

// MARK: - Interactor Input Protocol
protocol ProfileScreenInteractorInputProtocol {

}

// MARK: - Interactor Output Protocol
protocol ProfileScreenInteractorOutputProtocol: AnyObject {
    
}

// MARK: - ProfileScreen InteractorInput
class ProfileScreenInteractorInput {
    weak var output: ProfileScreenInteractorOutputProtocol?
}

// MARK: - ProfileScreen InteractorInputProtocol
extension ProfileScreenInteractorInput: ProfileScreenInteractorInputProtocol {

}
