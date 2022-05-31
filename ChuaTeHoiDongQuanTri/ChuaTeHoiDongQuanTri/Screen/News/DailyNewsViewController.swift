//
//  
//  DailyNewsViewController.swift
//  ChuTeHoiDongQuanTri
//
//  Created by Valerian on 31/05/2022.
//
//

import UIKit

// MARK: - ViewProtocol
protocol DailyNewsViewProtocol: AnyObject {

}

// MARK: - DailyNews ViewController
class DailyNewsViewController: BaseViewController {
    var router: DailyNewsRouterProtocol!
    var viewModel: DailyNewsViewModelProtocol!
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupInit()
        self.viewModel.onViewDidLoad()
    }
    
    // MARK: - Init
    private func setupInit() {

    }
    
    // MARK: - Action
    
}

// MARK: - DailyNews ViewProtocol
extension DailyNewsViewController: DailyNewsViewProtocol {
   
}
