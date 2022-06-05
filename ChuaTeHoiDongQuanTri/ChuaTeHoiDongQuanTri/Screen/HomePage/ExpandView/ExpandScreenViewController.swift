//
//  ExpandScreenViewController.swift
//  ChuaTeHoiDongQuanTri
//
//  Created by Valerian on 29/03/2022.
//  
//

import UIKit
import CoreAudio
import IGListKit

class ExpandScreenViewController: BaseViewController {
    // MARK: - Properties
    var presenter: ExpandScreenPresenterProtocol?
    var listMoviePassed: HomeAlbumsDetailModels?
    var objects = [ListDiffable]()
    var index = 0
    var loading = false

    @IBOutlet weak var expandCollectionView : UICollectionView!
    
    lazy var adapter: ListAdapter =  {
        let updater = ListAdapterUpdater()
        let adapter = ListAdapter(updater: updater, viewController: self, workingRangeSize: 0)
        adapter.collectionView = expandCollectionView
        adapter.dataSource = self
        return adapter
    }()
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.unlockScreen()
    }
}
// MARK: - UIScrollViewDelegate
extension ExpandScreenViewController: UIScrollViewDelegate {
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
                    self.presenter?.onGetAlbumsDetail(with: self.listMoviePassed?.id ?? 0, loadOn: self.index)
                }
            }
        }
    }
}

//MARK: - set up IGListKit
extension ExpandScreenViewController: ListAdapterDataSource {
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return objects
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        let sectionController = ExpandSectionController()
        sectionController.handleTapDelegate = self
        return sectionController
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }
}

//MARK: - Handle user tap to go to detail
extension ExpandScreenViewController: HandleTapProtocol {
    func ondidSelect(with model: ContentModels) {
        self.presentLockScreen()
        self.presenter?.openDetailView(id: Int(model.contentId!)!, category: model.domainType!)
    }
}

extension ExpandScreenViewController {
    
    //MARK: - set up view
    func setupView() {
        _ = adapter
        adapter.scrollViewDelegate = self
        navigationItem.title = listMoviePassed?.name
        if let data = self.listMoviePassed {
            self.objects.append(data)
            self.adapter.performUpdates(animated: true, completion: nil)
        }
    }
}

//MARK: - ExpandScreenViewProtocol
extension ExpandScreenViewController: ExpandScreenViewProtocol{
    // TODO: Implement View Output Methods
    
    func didGetAlbumsDetailFinish(with list: HomeAlbumsDetailModels) {
        self.objects.append(list)
        self.adapter.performUpdates(animated: true, completion: nil)
    }
}


