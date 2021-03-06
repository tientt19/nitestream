//
//  
//  DailyNewsViewController.swift
//  ChuTeHoiDongQuanTri
//
//  Created by Valerian on 31/05/2022.
//
//

import UIKit
import IGListKit

// MARK: - ViewProtocol
protocol DailyNewsViewProtocol: AnyObject {
    func onReceiveDaiyNewsData(with source: DailyNewsModel?)
}

// MARK: - DailyNews ViewController
class DailyNewsViewController: BaseViewController {
    
    @IBOutlet weak var clv_niteStreamNews: UICollectionView!
    
    var objects = [ListDiffable]()
    var router: DailyNewsRouterProtocol!
    var viewModel: DailyNewsViewModelProtocol!
    var index = 0
    var loading = false
    
    lazy var adapter: ListAdapter = {
        return ListAdapter(updater: ListAdapterUpdater(), viewController: self)
    }()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupInit()
        self.viewModel.onViewDidLoad()
    }
    
    // MARK: - Init
    private func setupInit() {        
        self.view.addSubview(self.clv_niteStreamNews)
        self.adapter.collectionView = self.clv_niteStreamNews
        self.adapter.dataSource = self
        self.adapter.scrollViewDelegate = self
    }
    
    // MARK: - Action
}

// MARK: - UIScrollViewDelegate
extension DailyNewsViewController: UIScrollViewDelegate {
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
extension DailyNewsViewController: ListAdapterDataSource {
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return self.objects
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        let sectionController = DailyNewsSectionController()
        sectionController.delegate = self
        return sectionController
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? { return nil }
}

// MARK: - DailyNews ViewProtocol
extension DailyNewsViewController: DailyNewsViewProtocol {
    func onReceiveDaiyNewsData(with source: DailyNewsModel?) {
        self.objects.append(source!)
        self.adapter.performUpdates(animated: true, completion: nil)
    }
}

//MARK: - DailyNewsSectionDelegate
extension DailyNewsViewController: DailyNewsSectionDelegate {
    func onGetDataPass(with model: NewsModel?) {
        self.router.onOpenWebView(with: model)
    }
}
