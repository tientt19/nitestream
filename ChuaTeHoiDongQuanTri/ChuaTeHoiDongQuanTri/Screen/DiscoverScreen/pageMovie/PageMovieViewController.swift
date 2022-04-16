//
//  
//  PageMovieViewController.swift
//  ChuTeHoiDongQuanTri
//
//  Created by Valerian on 16/04/2022.
//
//

import UIKit

// MARK: - ViewProtocol
protocol PageMovieViewProtocol: AnyObject {
    func showHud()
    func hideHud()
}

// MARK: - PageMovie ViewController
class PageMovieViewController: BaseViewController {
    var router: PageMovieRouterProtocol!
    var viewModel: PageMovieViewModelProtocol!
    
    
    
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

// MARK: - PageMovie ViewProtocol
extension PageMovieViewController: PageMovieViewProtocol {
    func showHud() {
    }
    
    func hideHud() {
    }
}
