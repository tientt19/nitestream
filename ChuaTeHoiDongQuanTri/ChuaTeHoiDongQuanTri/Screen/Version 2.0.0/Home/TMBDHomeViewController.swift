//
//  
//  TMBDHomeViewController.swift
//  nitestream
//
//  Created by Valerian on 18/07/2022.
//
//

import UIKit

// MARK: - ViewProtocol
protocol TMBDHomeViewProtocol: AnyObject {
    func showHud()
    func hideHud()
    
    //UITableView
    //func onReloadData()
}

// MARK: - TMBDHome ViewController
class TMBDHomeViewController: BaseViewController {
    var router: TMBDHomeRouterProtocol!
    var viewModel: TMBDHomeViewModelProtocol!
    
    
    
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

// MARK: - TMBDHome ViewProtocol
extension TMBDHomeViewController: TMBDHomeViewProtocol {
    func showHud() {
        self.showProgressHud()
    }
    
    func hideHud() {
        self.hideProgressHud()
    }
}
