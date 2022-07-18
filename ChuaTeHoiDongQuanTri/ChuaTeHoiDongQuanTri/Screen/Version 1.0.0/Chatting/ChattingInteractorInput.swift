//
//  
//  ChattingInteractorInput.swift
//  nitestream
//
//  Created by Valerian on 20/06/2022.
//
//

import UIKit

// MARK: - Interactor Input Protocol
protocol ChattingInteractorInputProtocol {

}

// MARK: - Interactor Output Protocol
protocol ChattingInteractorOutputProtocol: AnyObject {
    
}

// MARK: - Chatting InteractorInput
class ChattingInteractorInput {
    weak var output: ChattingInteractorOutputProtocol?
}

// MARK: - Chatting InteractorInputProtocol
extension ChattingInteractorInput: ChattingInteractorInputProtocol {

}
