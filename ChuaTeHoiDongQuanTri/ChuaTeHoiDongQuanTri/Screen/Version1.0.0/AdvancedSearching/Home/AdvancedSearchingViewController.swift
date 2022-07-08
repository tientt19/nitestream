//
//  
//  AdvancedSearchingViewController.swift
//  ChuTeHoiDongQuanTri
//
//  Created by Valerian on 11/06/2022.
//
//

import UIKit

// MARK: - ViewProtocol
protocol AdvancedSearchingViewProtocol: AnyObject {

}

// MARK: - AdvancedSearching ViewController
class AdvancedSearchingViewController: BaseViewController {
    var router: AdvancedSearchingRouterProtocol!
    var viewModel: AdvancedSearchingViewModelProtocol!
    @IBOutlet weak var view_containerPageView: UIView!
    
    // Page tab
    private lazy var pageViewController: VXPageViewController = VXPageViewController()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupInit()
        self.viewModel.onViewDidLoad()
    }
    
    // MARK: - Init
    private func setupInit() {
        self.setInitPageViewController()
    }
    
    // MARK: - Action
    
}

// MARK: - AdvancedSearching ViewProtocol
extension AdvancedSearchingViewController: AdvancedSearchingViewProtocol {
    //MARK: - VX Page Bar
    private func setInitPageViewController() {
        let barConfig = VXPageBarConfig(height: 48,
                                        selectedColor: UIColor.systemIndigo,
                                        unSelectedColor: UIColor.darkText,
                                        selectedFont: UIFont(name: "roboto", size: 14),
                                        unSelectedFont: UIFont(name: "roboto", size: 14),
                                        underLineHeight: 3,
                                        underLineWidth: 60,
                                        underLineColor: UIColor.systemIndigo,
                                        backgroundColor: .white)
        
        let pageTVSeries = VXPageItem(viewController: TVSeriesRouter.setupModule(), title: "TV Series")
        let pageMovie = VXPageItem(viewController: MoviesRouter.setupModule(), title: "Movie")
        let pageAnime = VXPageItem(viewController: AnimeRouter.setupModule(), title: "Anime")
        
        self.pageViewController.setPageItems([pageTVSeries, pageMovie, pageAnime])
        self.pageViewController.setPageBarConfig(barConfig)
        
        self.addChild(self.pageViewController)
        
        self.view_containerPageView.addSubview(self.pageViewController.view)
        self.pageViewController.view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        self.pageViewController.didMove(toParent: self)
    }
}
