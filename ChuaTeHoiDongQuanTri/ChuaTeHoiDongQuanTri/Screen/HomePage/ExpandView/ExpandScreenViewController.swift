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
    var listMoviePassed = RecommendItem(fromDictionary: ["" : ""])
    internal var collectionViewDatasource : CollectionviewDataSource?
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
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        unlockScreen()
    }
}

extension ExpandScreenViewController: ListAdapterDataSource {
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return [listMoviePassed]
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        return ExpandSectionController()
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }
}

extension ExpandScreenViewController {
    
    //MARK: - set up view
    func setupView() {
        _ = adapter
        navigationItem.title = listMoviePassed.homeSectionName
//        collectionViewDatasource = ExpandCollectionViewDataSource(entities: listMoviePassed, with: presenter!)
//        expandCollectionView.registerCell(nibName: MovieCell.self)
//        expandCollectionView.reloadData()
    }
}

////MARK: - UICollectionViewDataSourcePrefetching
//extension ExpandScreenViewController : UICollectionViewDataSourcePrefetching {
//    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
//        collectionViewDatasource?.prefetchingData(collectionView, prefetchItemsAt: indexPaths)
//    }
//}

////MARK: - UICollectionViewDelegate
//extension ExpandScreenViewController: UICollectionViewDelegate {
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        presentLockScreen()
//        collectionViewDatasource?.didSelect(collectionView: collectionView, indexPath: indexPath)
//    }
//}
//
////MARK: - UICollectionViewDataSource
//extension ExpandScreenViewController: UICollectionViewDataSource {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return listMoviePassed.recommendContentVOList.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        return collectionViewDatasource?.itemCell(collectionView: collectionView, indexPath: indexPath) ?? UICollectionViewCell()
//    }
//}
////MARK: - UICollectionViewDelegateFlowLayout
//extension ExpandScreenViewController: UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat { return 5 }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat { return 5 }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return collectionViewDatasource?.sizeForItem(collectionView, layout: collectionViewLayout, sizeForItemAt: indexPath) ?? CGSize(width: 0, height: 0)
//    }
//}

//MARK: - ExpandScreenViewProtocol
extension ExpandScreenViewController: ExpandScreenViewProtocol{
    // TODO: Implement View Output Methods
}

