//
//  
//  DiscoveryScreenViewController.swift
//  ChuTeHoiDongQuanTri
//
//  Created by admin on 05/04/2022.
//
//

import UIKit

class DiscoveryScreenViewController: BaseViewController {

    var presenter: DiscoveryScreenPresenterProtocol!
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupInit()
        self.presenter.onViewDidLoad()
    }
    
    // MARK: - Setup
    private func setupInit() {

    }
    
    // MARK: - Action
    
}

// MARK: - DiscoveryScreenViewProtocol
extension DiscoveryScreenViewController: DiscoveryScreenViewProtocol {
    
}
