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

    @IBOutlet weak var view_Container: UIView!
    var presenter: DiscoveryScreenPresenterProtocol!
    // Page tab
    private lazy var pageViewController: VXPageViewController = VXPageViewController()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupInit()
        self.presenter.onViewDidLoad()
    }
    
    // MARK: - Setup
    private func setupInit() {
        self.activityIndicatorView.startAnimating()
        self.setInitPageViewController()
    }
    
    // MARK: - Action
    
}

// MARK: - DiscoveryScreenViewProtocol
extension DiscoveryScreenViewController: DiscoveryScreenViewProtocol {
    func reloadData() {
       
    }
}

//MARK: - VX Page Bar
extension DiscoveryScreenViewController {
    private func setInitPageViewController() {
        let barConfig = VXPageBarConfig(height: 48,
                                        selectedColor: UIColor.systemIndigo,
                                        unSelectedColor: UIColor.darkText,
                                        selectedFont: UIFont(name: "roboto", size: 12),
                                        unSelectedFont: UIFont(name: "roboto", size: 12),
                                        underLineHeight: 3,
                                        underLineWidth: 60,
                                        underLineColor: UIColor.systemIndigo,
                                        backgroundColor: .white)
        
        let pageTVSeries = VXPageItem(viewController: PageTVSeriesRouter.setupModule(), title: "TV Series")
        let pageMovie = VXPageItem(viewController: PageMovieRouter.setupModule(), title: "Movie")
        let pageAnime = VXPageItem(viewController: PageAnimeRouter.setupModule(), title: "Anime")
        
        self.pageViewController.setPageItems([pageTVSeries, pageMovie, pageAnime])
        self.pageViewController.setPageBarConfig(barConfig)
        
        self.addChild(self.pageViewController)
        
        self.view_Container.addSubview(self.pageViewController.view)
        self.pageViewController.view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        self.pageViewController.didMove(toParent: self)
    }
}
