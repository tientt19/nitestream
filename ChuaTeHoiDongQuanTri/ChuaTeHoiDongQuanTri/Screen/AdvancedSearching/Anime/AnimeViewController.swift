//
//  
//  AnimeViewController.swift
//  ChuTeHoiDongQuanTri
//
//  Created by Valerian on 11/06/2022.
//
//

import UIKit

// MARK: - ViewProtocol
protocol AnimeViewProtocol: AnyObject {

}

// MARK: - Anime ViewController
class AnimeViewController: BaseViewController {
    var router: AnimeRouterProtocol!
    var viewModel: AnimeViewModelProtocol!
    
    
    
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

// MARK: - Anime ViewProtocol
extension AnimeViewController: AnimeViewProtocol {

}
