//
//  
//  PageAnimeViewController.swift
//  ChuTeHoiDongQuanTri
//
//  Created by Valerian on 16/04/2022.
//
//

import UIKit

// MARK: - ViewProtocol
protocol PageAnimeViewProtocol: AnyObject {
    func showHud()
    func hideHud()
}

// MARK: - PageAnime ViewController
class PageAnimeViewController: BaseViewController {
    var router: PageAnimeRouterProtocol!
    var viewModel: PageAnimeViewModelProtocol!
    
    
    
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

// MARK: - PageAnime ViewProtocol
extension PageAnimeViewController: PageAnimeViewProtocol {
    func showHud() {
    }
    
    func hideHud() {
    }
}
