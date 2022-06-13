//
//  
//  TVSeriesViewController.swift
//  ChuTeHoiDongQuanTri
//
//  Created by Valerian on 11/06/2022.
//
//

import UIKit
import IGListKit

// MARK: - ViewProtocol
protocol TVSeriesViewProtocol: AnyObject {
    func didGetSearchListFinished(with model: [SearchListModel])
}

// MARK: - TVSeries ViewController
class TVSeriesViewController: BaseViewController {
    var router: TVSeriesRouterProtocol!
    var viewModel: TVSeriesViewModelProtocol!
    
    var objects = [ListDiffable]()
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    lazy var adapter: ListAdapter =  {
        let updater = ListAdapterUpdater()
        let adapter = ListAdapter(updater: updater, viewController: self, workingRangeSize: 0)
        adapter.collectionView = collectionView
        adapter.dataSource = self
//        adapter.scrollViewDelegate = self
        return adapter
    }()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupInit()
        self.viewModel.onViewDidLoad()
        self.viewModel.onGetSearchResult(with: DiscoveryParams.TVSeries.toString)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.collectionView.frame = self.view.bounds
    }
    
    // MARK: - Init
    private func setupInit() {
        self.view.addSubview(self.collectionView)
        _ = adapter
    }
    
    // MARK: - Action
}

//MARK: - ListAdapterDataSource
extension TVSeriesViewController: ListAdapterDataSource {
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return self.objects
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        let sectionController = TVSeriesSectionControler()
        return sectionController
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? { return nil }
}

// MARK: - TVSeries ViewProtocol
extension TVSeriesViewController: TVSeriesViewProtocol {
    func didGetSearchListFinished(with model: [SearchListModel]) {
        self.objects.append(contentsOf: model[0].screeningItems!)
        self.adapter.performUpdates(animated: true, completion: nil)
    }
}
