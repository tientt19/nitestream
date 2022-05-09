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
    func didGetListSearchingFinish(with data: [SearchingModelIG])
    func didGetSearchingListFinish(with data: [TopSearchData])
}

// MARK: - SearchingIGListKitScreen ViewController
class SearchingIGListKitScreenViewController: BaseViewController {
    var router: SearchingIGListKitScreenRouterProtocol!
    var viewModel: SearchingIGListKitScreenViewModelProtocol!
    var objects = [ListDiffable]()
    
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
        self.collectionView.keyboardDismissMode = .onDrag
        self.adapter.dataSource = self
        self.adapter.scrollViewDelegate = self
    }
    
    // MARK: - Action
}

extension SearchingIGListKitScreenViewController {
    func setUPView() {
        self.setUpBaseView()
        self.hideKeyboardWhenTappedAround()
        self.navigationItem.titleView = self.coverTextFieldView
        self.textFieldView.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if textField.text == "" {
            self.viewModel.onViewDidLoad()
        } else if let searchKey = textField.text {
            self.viewModel.onSearchWithKeyWork(with: searchKey)
        }
    }
}

//MARK: - Hande user tap
extension SearchingIGListKitScreenViewController: onTapDetailProtocol {
    func didSelect(with data: String) {
        self.viewModel.ongetListSearch(with: data.htmlToString)
    }
    
    func didSelect(with data: TopSearchData) {
        presentLockScreen()
        self.viewModel.openDetailView(id: data.id, category: data.domainType)
    }
}

// MARK: - UIScrollViewDelegate
extension SearchingIGListKitScreenViewController: UIScrollViewDelegate {
    
}

//MARK: - ListAdapterDataSource
extension SearchingIGListKitScreenViewController: ListAdapterDataSource {
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return objects
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        if object is TopSearchData {
            let sectionController = SearchingIGListKitSectionController()
            sectionController.handleTapDelegate = self
            return sectionController
        } else {
            let searchingSectionController = SearchingListSectionController()
            searchingSectionController.handleTapDelegate = self
            return searchingSectionController
        }
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? { return generateEmptyView() }
}

// MARK: - SearchingIGListKitScreen ViewProtocol
extension SearchingIGListKitScreenViewController: SearchingIGListKitScreenViewProtocol {
    func didGetSearchingListFinish(with data: [TopSearchData]) {
        self.update(with: data)
    }
    
    func didGetListSearchingFinish(with data: [SearchingModelIG]) {
        self.update(with: data)
    }
    
    func didGetDetailViewFinish(with data: MovieDetail) {
        DispatchQueue.main.async {
            self.router.openDetailMovie(from: self, for: data)
        }
    }
    
    func onUpdateData(with data: [TopSearchData]) {
        self.update(with: data)
    }
    
    func update(with data: [ListDiffable]) {
        self.objects.removeAll()
        self.objects.append(contentsOf: data)
        self.adapter.performUpdates(animated: true, completion: nil)
    }
}
