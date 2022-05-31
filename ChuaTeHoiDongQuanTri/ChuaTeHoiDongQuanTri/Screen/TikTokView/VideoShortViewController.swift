//
//  
//  VideoShortViewController.swift
//  ChuTeHoiDongQuanTri
//
//  Created by Valerian on 27/05/2022.
//
//

import UIKit
import IGListKit

// MARK: - ViewProtocol
protocol VideoShortViewProtocol: AnyObject {
    func onReceiveShortVideoData(with source: ShortVideoModel?, info: ReviewShortVideoModel?)
}

// MARK: - VideoShort ViewController
class VideoShortViewController: BaseViewController {
    var objects = [ListDiffable]()
    var router: VideoShortRouterProtocol!
    var viewModel: VideoShortViewModelProtocol!
    var loading = false
    var index = 0
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    lazy var adapter: ListAdapter = {
        return ListAdapter(updater: ListAdapterUpdater(), viewController: self)
    }()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupInit()
        self.viewModel.onViewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.collectionView.frame = self.view.bounds
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.post(name: .stopPlayingMedia, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: .stopPlayingMedia, object: nil)
    }
    
    // MARK: - Init
    private func setupInit() {
        self.view.addSubview(self.collectionView)
        self.collectionView.backgroundColor = .clear
        self.collectionView.isPagingEnabled = true
        self.adapter.collectionView = self.collectionView
        self.adapter.dataSource = self
        self.adapter.scrollViewDelegate = self
    }
    
    // MARK: - Action
    
}

// MARK: - UIScrollViewDelegate
extension VideoShortViewController: UIScrollViewDelegate {
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
                    self.viewModel.onLoadMoreData(with: self.index)
                }
            }
        }
    }
}

//MARK: - ListAdapterDataSource
extension VideoShortViewController: ListAdapterDataSource {
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return self.objects
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        let sectionController = VideoShortSectionController()
        return sectionController
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? { return nil }
}

// MARK: - VideoShort ViewProtocol
extension VideoShortViewController: VideoShortViewProtocol {
    func onReceiveShortVideoData(with source: ShortVideoModel?, info: ReviewShortVideoModel?) {
        let data = VideoShortModel(source!, info!)
        self.objects.append(data)
        self.adapter.performUpdates(animated: true, completion: nil)
    }
}
