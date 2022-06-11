//
//  
//  TVSeriesViewController.swift
//  ChuTeHoiDongQuanTri
//
//  Created by Valerian on 11/06/2022.
//
//

import UIKit

// MARK: - ViewProtocol
protocol TVSeriesViewProtocol: AnyObject {

}

// MARK: - TVSeries ViewController
class TVSeriesViewController: BaseViewController {
    var router: TVSeriesRouterProtocol!
    var viewModel: TVSeriesViewModelProtocol!
    
    
    
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

// MARK: - TVSeries ViewProtocol
extension TVSeriesViewController: TVSeriesViewProtocol {

}
