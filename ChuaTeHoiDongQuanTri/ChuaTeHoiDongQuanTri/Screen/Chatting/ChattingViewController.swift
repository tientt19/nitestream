//
//  
//  ChattingViewController.swift
//  nitestream
//
//  Created by Valerian on 20/06/2022.
//
//

import UIKit
import FirebaseAuth

// MARK: - ViewProtocol
protocol ChattingViewProtocol: AnyObject {

}

// MARK: - Chatting ViewController
class ChattingViewController: BaseViewController {
    var router: ChattingRouterProtocol!
    var viewModel: ChattingViewModelProtocol!
    
    
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupInit()
        self.viewModel.onViewDidLoad()
    }
    
    // MARK: - Init
    private func setupInit() {
        self.title = Auth.auth().currentUser?.displayName
    }
    
    // MARK: - Action
    
}

// MARK: - Chatting ViewProtocol
extension ChattingViewController: ChattingViewProtocol {
  
}
