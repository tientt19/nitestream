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

    @IBOutlet weak var atabileView: UITableView!
    var presenter: DiscoveryScreenPresenterProtocol!
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad() 
        self.setupInit()
        self.presenter.onViewDidLoad()
    }
    
    // MARK: - Setup
    private func setupInit() {
        self.registerCell()
    }
    
    private func registerCell() {
        self.atabileView.registerCell(nibName: DiscoveryTableViewCell.self)
        self.atabileView.delegate = self
        self.atabileView.dataSource = self
        self.atabileView.separatorStyle = .none
    }
    
    // MARK: - Action
    
}

// MARK: - DiscoveryScreenViewProtocol
extension DiscoveryScreenViewController: DiscoveryScreenViewProtocol {
    func reloadData() {
        DispatchQueue.main.async {
            self.atabileView.reloadData()
        }
    }
}

// MARK: - UITableViewDelegate
extension DiscoveryScreenViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
}

// MARK: - UITableViewDataSource
extension DiscoveryScreenViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return presenter.numberOfSection
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfCell
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(cellClass: DiscoveryTableViewCell.self, forIndexPath: indexPath)
        cell.model = presenter.itemForRow(at: indexPath)
        return cell
    }
}

// MARK: VX Page Bar
//extension DiscoveryScreenViewController {
//    private func setInitPageViewController() {
//        let barConfig = VXPageBarConfig(height: 48,
//                                      selectedColor: R.color.darkText(),
//                                      unSelectedColor: R.color.subTitle(),
//                                      selectedFont: R.font.robotoMedium(size: 16),
//                                      unSelectedFont: R.font.robotoRegular(size: 16),
//                                      underLineHeight: 3,
//                                      underLineWidth: 60,
//                                      underLineColor: R.color.mainColor(),
//                                      backgroundColor: .white)
//
//        let pageProgram = VXPageItem(viewController: ProgramFitRouter.setupModule(), title: "Chương trình")
//        let pageLibrary = VXPageItem(viewController: LibraryFitRouter.setupModule(), title: "Thư viện")
//        let pagePractice = VXPageItem(viewController: MyWorkoutFitRouter.setupModule(), title: "Bài tập")
//        let pageAchievement = VXPageItem(viewController: AchievementFitRouter.setupModule(), title: "Thành tích")
//
//        //let pageCommunity = VXPageItem(viewController: CommunityFitRouter.setupModule(), title: "Cộng đồng")
//        //let pagePersonal = VXPageItem(viewController: PersonalFitRouter.setupModule(), title: "Cá nhân")
//
//        self.pageViewController.setPageItems([pageProgram, pageLibrary, pagePractice, pageAchievement])
//        //self.pageViewController.setPageItems([pageLibrary, pageCommunity, pagePersonal])
//        self.pageViewController.setPageBarConfig(barConfig)
//
//        self.addChild(self.pageViewController)
//
//        self.view_ContainerPage.addSubview(self.pageViewController.view)
//        self.pageViewController.view.snp.makeConstraints { make in
//            make.edges.equalToSuperview()
//        }
//        self.pageViewController.didMove(toParent: self)
//    }
//}
