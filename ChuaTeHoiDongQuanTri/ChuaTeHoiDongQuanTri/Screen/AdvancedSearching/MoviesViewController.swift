//
//  
//  MoviesViewController.swift
//  ChuTeHoiDongQuanTri
//
//  Created by Valerian on 11/06/2022.
//
//

import UIKit
import IGListKit

// MARK: - ViewProtocol
protocol MoviesViewProtocol: AnyObject {
    func didGetSearchListFinished(with model: [SearchListModel])
    func didGetAdvancedSearchResult(with model: SearchResultModel)
}

// MARK: - Movies ViewController
class MoviesViewController: BaseViewController {
    var router: MoviesRouterProtocol!
    var viewModel: MoviesViewModelProtocol!
    
    var objects = [ListDiffable]()
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    lazy var adapter: ListAdapter =  {
        let updater = ListAdapterUpdater()
        let adapter = ListAdapter(updater: updater, viewController: self, workingRangeSize: 0)
        adapter.collectionView = collectionView
        adapter.dataSource = self
        return adapter
    }()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupInit()
        self.viewModel.onViewDidLoad()
        self.viewModel.onGetSearchResult(with: DiscoveryParams.Movie.toString)
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
extension MoviesViewController: ListAdapterDataSource {
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return self.objects
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        if object is SearchResultModel {
            return SearchResultSectionController()
        } else {
            return SearchListSectionController()
        }
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? { return nil }
}

// MARK: - Movies ViewProtocol
extension MoviesViewController: MoviesViewProtocol {
    func didGetSearchListFinished(with model: [SearchListModel]) {
        self.objects.append(contentsOf: model[1].screeningItems!)
        self.adapter.performUpdates(animated: true, completion: nil)
    }
    
    func didGetAdvancedSearchResult(with model: SearchResultModel) {
        self.objects.append(model)
        self.adapter.performUpdates(animated: true, completion: nil)
    }
}
