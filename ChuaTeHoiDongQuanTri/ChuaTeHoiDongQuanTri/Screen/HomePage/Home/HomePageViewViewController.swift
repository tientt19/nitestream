//
//  HomePageViewViewController.swift
//  ChuaTeHoiDongQuanTri
//
//  Created by Valerian on 01/04/2022.
//  
//

import UIKit
import IGListKit

class HomePageViewViewController: BaseViewController {
    // MARK: - Properties
//    @IBOutlet weak var HomePageCLV: UICollectionView!
    @IBOutlet weak var viewCanMove: UIView!
    @IBOutlet weak var limitView: UIView!
    
    @IBOutlet weak var bottomViewConMoveConstraint: NSLayoutConstraint!
    @IBOutlet weak var trailingViewConMoveConstraint: NSLayoutConstraint!
    
    var presenter: HomePageViewPresenterProtocol?
    var dataSource : HomePageViewDataSourceProtocol?
    var loading = false
    var index = 0
    var objects = [ListDiffable]()
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    lazy var adapter: ListAdapter = {
        return ListAdapter(updater: ListAdapterUpdater(), viewController: self)
    }()
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.register()
        self.presentLockScreen()
        self.presenter?.getHomePageData(index)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.collectionView.frame = self.view.bounds
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.unlockScreen()
    }
        
    func register() {
        self.setUpBaseView()
        navigationItem.titleView = self.textFieldView
        
        textFieldView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(textFieldTap)))
        viewCanMove.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handleViewCanMove)))
       
        self.view.addSubview(self.collectionView)
        self.adapter.collectionView = collectionView
        self.adapter.dataSource = self
        self.adapter.scrollViewDelegate = self
    }
    
    @IBAction func handleCloseViewCanMove(_ sender: UIButton) {
        self.viewCanMove.isHidden = true
    }
    @objc func textFieldTap() {
        let searchingVC = SearchingIGListKitScreenRouter.setupModule()
        searchingVC.hidesBottomBarWhenPushed = true
        searchingVC.navigationItem.backBarButtonItem = UIBarButtonItem(title: String(), style: .plain, target: nil, action: nil)
        self.navigationController?.pushViewController(searchingVC, animated: true)
    }
    
    @objc func handleViewCanMove(gesture : UIPanGestureRecognizer) {
        //
        guard gesture.view != nil else {return}
        //
        let translation = gesture.translation(in: self.limitView)

        let bounds = UIScreen.main.bounds
        
        // 50 = viewWidth / 2
        if self.trailingViewConMoveConstraint.constant + translation.x <= -50 && self.trailingViewConMoveConstraint.constant + translation.x >=  0 - bounds.size.width + 50 {
            self.trailingViewConMoveConstraint.constant += translation.x
        }
        
        if self.bottomViewConMoveConstraint.constant + translation.y <= -50 && self.bottomViewConMoveConstraint.constant + translation.y >= 0 - bounds.size.height + 50 + 170 {
            self.bottomViewConMoveConstraint.constant += translation.y
        }
        
        gesture.setTranslation(.zero, in: self.limitView)
//        print("x: \( self.trailingViewConMoveConstraint.constant)")
//        print("y: \(self.bottomViewConMoveConstraint.constant)")
//        print("----------")
        self.view.layoutIfNeeded()
    }
}

// MARK: - UIScrollViewDelegate
extension HomePageViewViewController: UIScrollViewDelegate {
    func scrollViewWillEndDragging(_ scrollView: UIScrollView,
                                   withVelocity velocity: CGPoint,
                                   targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let distance = scrollView.contentSize.height - (targetContentOffset.pointee.y + scrollView.bounds.height)
        if !loading && distance < 200 {
            loading = true
            adapter.performUpdates(animated: true, completion: nil)
            DispatchQueue.global(qos: .default).async {
                // fake background loading task
                DispatchQueue.main.async {
                    self.presentLockScreen()
                    self.loading = false
                    self.index += 1
                    self.dataSource?.loadMore(self.index)
                }
            }
        }
    }
}

extension HomePageViewViewController: passDataPickDelegate {
    func openDetailView(_ data: RecommendContentVOList) {
        self.presentLockScreen()
        self.presenter?.onGetMovieDetail(data.id, data.category)
    }
}

//MARK: - ListAdapterDataSource
extension HomePageViewViewController: ListAdapterDataSource {
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return self.objects
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        let sectionController = BannerSectionController()
        sectionController.controller = self
        sectionController.openExpandViewDelegate = self
        return sectionController
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? { return nil }
}

//MARK: - HomePageViewViewProtocol
extension HomePageViewViewController: HomePageViewViewProtocol{
    
    // TODO: Implement View Output Methods
    func reloadData(_ data: HomePageModel) {
        self.dataSource = HomePageViewDataSource(entities: data, with: presenter!)
        self.unlockScreen()
        self.objects.removeAll()
        for item in data.recommendItems {
            self.objects.append(item)
        }
        self.adapter.performUpdates(animated: true, completion: nil)
    }
    
    func lockView() {
        self.presentLockScreen()
    }
}

//MARK: - HandleExpandViewOpenProtocols
extension HomePageViewViewController: HandleExpandViewOpenProtocols {
    func onOpenExpand(with data: RecommendItem) {
        self.presenter?.openExpandView(with: data)
    }
}
