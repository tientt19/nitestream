//
//  
//  MoviesViewController.swift
//  ChuTeHoiDongQuanTri
//
//  Created by Valerian on 11/06/2022.
//
//

import UIKit

// MARK: - ViewProtocol
protocol MoviesViewProtocol: AnyObject {

}

// MARK: - Movies ViewController
class MoviesViewController: BaseViewController {
    var router: MoviesRouterProtocol!
    var viewModel: MoviesViewModelProtocol!
    
    
    
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

// MARK: - Movies ViewProtocol
extension MoviesViewController: MoviesViewProtocol {

}
