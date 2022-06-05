//
//  HomePageViewViewController.swift
//  ChuaTeHoiDongQuanTri
//
//  Created by Valerian on 01/04/2022.
//  
//

import UIKit
import FirebaseAuth
import IGListKit

class HomePageViewViewController: BaseViewController {
    // MARK: - Properties
    var presenter: HomePageViewPresenterProtocol?
    var loading = false
    var index = 0
    var objects = [ListDiffable]()
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    lazy var adapter: ListAdapter =  {
        let updater = ListAdapterUpdater()
        let adapter = ListAdapter(updater: updater, viewController: self, workingRangeSize: 0)
        adapter.collectionView = collectionView
        adapter.dataSource = self
        adapter.scrollViewDelegate = self
        return adapter
    }()
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.register()
        
        //new
        self.presenter?.onGetHomeAlbums(with: self.index)
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
        if let avatarImage = Auth.auth().currentUser?.photoURL {
            self.setAvatarImage(with: avatarImage)
        }
        navigationItem.titleView = self.searchView
        
        self.textFieldView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(textFieldTap)))
        
        self.view.addSubview(self.collectionView)
        _ = adapter
    }
    
    @objc func textFieldTap() {
        let searchingVC = SearchingIGListKitScreenRouter.setupModule()
        searchingVC.hidesBottomBarWhenPushed = true
        searchingVC.navigationItem.backBarButtonItem = UIBarButtonItem(title: String(), style: .plain, target: nil, action: nil)
        self.navigationController?.pushViewController(searchingVC, animated: true)
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
                    self.loading = false
                    self.index += 1
                    self.presenter?.onGetHomeAlbums(with: self.index)
                }
            }
        }
    }
}

extension HomePageViewViewController: passDataPickDelegate {
    func openAlmbumDetaik(with refID: Int?) {
        self.presenter?.onGetAlbumsDetail(with: refID ?? 0, loadOn: 0)
    }
    
    func openDetailView(_ data: RecommendContentVOListModel) {
        self.presentLockScreen()
        self.presenter?.onGetMovieDetail(data.id!, data.category!)
    }
}

extension HomePageViewViewController: BannerTapDelegate {
    func onDidselect(with model: HomeBannerModels) {
//        self.presenter?.onGetMovieDetail(Int(model.jumpParam!)!, model.id!)
    }
}

//MARK: - ListAdapterDataSource
extension HomePageViewViewController: ListAdapterDataSource {
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return self.objects
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        if object is HomeListBannerModel {
            let sectionController = HomePageBannerSectionController()
            sectionController.controller = self
            return sectionController
        } else {
            let sectionController = HomePageAlbumsSectionController()
            sectionController.controller = self
            return sectionController
        }
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? { return nil }
}

//MARK: - HomePageViewViewProtocol
extension HomePageViewViewController: HomePageViewViewProtocol{
    func didGetAlbumsDetailFinish(with list: HomeAlbumsDetailModels) {
        // open
        self.presenter?.openExpandView(with: list)
    }
    
    func lockView() {
        self.presentLockScreen()
    }
    
    //new
    func didGetHomePageFinish(with albums: HomePageModels, listBanners: [HomeBannerModels]) {
        if self.index == 0 {
            let listBanner = HomeListBannerModel(banners: listBanners)
            self.objects.append(listBanner)
        }
        self.objects.append(albums)
        dLogDebug(self.objects)
        self.adapter.performUpdates(animated: true, completion: nil)
    }
}

