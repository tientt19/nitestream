//
//  
//  SearchingIGListKitScreenViewController.swift
//  ChuTeHoiDongQuanTri
//
//  Created by Valerian on 05/05/2022.
//
//

import UIKit
import IGListKit

// MARK: - ViewProtocol
protocol SearchingIGListKitScreenViewProtocol: AnyObject {
    func onUpdateData(with data: [TopSearchData])
    func didGetDetailViewFinish(with data: MovieDetail)
}

// MARK: - SearchingIGListKitScreen ViewController
class SearchingIGListKitScreenViewController: BaseViewController {
    var router: SearchingIGListKitScreenRouterProtocol!
    var viewModel: SearchingIGListKitScreenViewModelProtocol!
    var listTopSearchData = [TopSearchData]()
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        unlockScreen()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.collectionView.frame = self.view.bounds
    }
    
    // MARK: - Init
    private func setupInit() {
        self.setUPView()
        self.view.addSubview(self.collectionView)
        self.adapter.collectionView = self.collectionView
        self.adapter.dataSource = self
        //        self.adapter.scrollViewDelegate = self
    }
    
    // MARK: - Action
    
}

extension SearchingIGListKitScreenViewController {
    func setUPView() {
        self.setUpBaseView()
        self.hideKeyboardWhenTappedAround()
        self.navigationItem.titleView = textFieldView
        self.textFieldView.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if textField.text == "" {
            activityIndicatorView.startAnimating()
            //            self.viewModel.onViewDidLoad()
            //            self.viewModel?.callToGetTopSearchingData()
        }
        
        //        if let searchKey = textField.text {
        //            self.viewModel?.handleSearchWithKeywork(searchKey)
        //        }
    }
}

//MARK: - Hande user tap

extension SearchingIGListKitScreenViewController: onTapDetailProtocol {
    func didSelect(with data: TopSearchData) {
        presentLockScreen()
        self.viewModel.openDetailView(id: data.id, category: data.domainType)
    }
}

//MARK: - ListAdapterDataSource
extension SearchingIGListKitScreenViewController: ListAdapterDataSource {
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return listTopSearchData
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        let sectionController = SearchingIGListKitSectionController()
        sectionController.handleTapDelegate = self
        return sectionController
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? { return nil }
}

// MARK: - SearchingIGListKitScreen ViewProtocol
extension SearchingIGListKitScreenViewController: SearchingIGListKitScreenViewProtocol {
    func didGetDetailViewFinish(with data: MovieDetail) {
        DispatchQueue.main.async {
            self.router.openDetailMovie(from: self, for: data)
        }
    }
    
    func onUpdateData(with data: [TopSearchData]) {
        self.listTopSearchData.append(contentsOf: data)
        self.adapter.performUpdates(animated: true, completion: nil)
    }
}
