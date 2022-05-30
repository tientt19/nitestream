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
    
}

// MARK: - VideoShort ViewController
class VideoShortViewController: BaseViewController {
    var objects = [ListDiffable]()
    var router: VideoShortRouterProtocol!
    var viewModel: VideoShortViewModelProtocol!
    
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
    
    // MARK: - Init
    private func setupInit() {

    }
    
    // MARK: - Action
    
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
}
