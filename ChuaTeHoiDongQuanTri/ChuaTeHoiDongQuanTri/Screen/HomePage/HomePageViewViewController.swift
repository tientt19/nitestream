//
//  HomePageViewViewController.swift
//  ChuaTeHoiDongQuanTri
//
//  Created by Valerian on 01/04/2022.
//  
//

import UIKit

class HomePageViewViewController: BaseViewController {
    // MARK: - Properties
    @IBOutlet weak var HomePageCLV: UICollectionView!
    
    var presenter: HomePageViewPresenterProtocol?
    var dataSource : HomePageViewDataSourceProtocol?
    var index = 0

    lazy var textFieldView : UITextField = {
        let textfield = UITextField(frame: CGRect(x: 0, y: 0, width: (self.navigationController?.navigationBar.frame.size.width)!, height: 30))
        textfield.borderStyle = .roundedRect
        textfield.placeholder = "Searching"
        return textfield
    }()
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpBaseView()
        register()
        presenter?.getHomePageData(index)
    }
        
    func register() {
        navigationItem.titleView = textFieldView
        
        //CELL
        HomePageCLV.registerCell(nibName: BannerCell.self)
        HomePageCLV.registerCell(nibName: CategoryCell.self)
        HomePageCLV.registerCellForHeader(nibName: MainHeader.self)
        HomePageCLV.registerCellForFooter(nibName: MainFooter.self)
        
        textFieldView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(textFieldTap)))
    }
    
    @objc func textFieldTap() {
        let searchingVC = SearchingRouter.createSearchingModule()
        searchingVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(searchingVC, animated: true)
    }
    
    //MARK: - Handle when tap collecion view header
    @objc func didSelectSection(gesture: UITapGestureRecognizer) {
        let indexPaths = self.HomePageCLV?.indexPathsForVisibleSupplementaryElements(ofKind: UICollectionView.elementKindSectionHeader)
        for indexPath in indexPaths! {
            if (gesture.view as! MainHeader) == HomePageCLV?.supplementaryView(forElementKind: UICollectionView.elementKindSectionHeader, at: indexPath){
                if let sendDataToExpand = dataSource?.listData().recommendItems[indexPath.section] {
                    let expandVC = ExpandScreenRouter.createModule(with: sendDataToExpand)
                    expandVC.hidesBottomBarWhenPushed = true
                    self.navigationController?.pushViewController(expandVC, animated: true)
                }
                break
            }
        }
    }
}

//MARK: - UICollectionViewDelegate
extension HomePageViewViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if indexPath.section == 0 {
            // handle item in section = 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.section == dataSource!.numberOfItems - 2 {
            index += 1
            // Load More
            dataSource?.loadMore(index)
        } 
    }
}

//MARK: - UICollectionViewDataSource
extension HomePageViewViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return dataSource?.numberOfItems ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return (dataSource?.itemCell(collectionView: collectionView, indexPath: indexPath))!
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = dataSource?.itemHeaderCell(collectionView, viewForSupplementaryElementOfKind: kind, at: indexPath)
        let gestureRecognizer: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didSelectSection(gesture:)))
        header!.addGestureRecognizer(gestureRecognizer)
        return header!
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension HomePageViewViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat { return 10 }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat { return 10 }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if dataSource?.listData().recommendItems[section].homeSectionType == "BANNER" {
            return CGSize(width: HomePageCLV.frame.width, height: 0)
        }
        return CGSize(width: HomePageCLV.frame.width, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: HomePageCLV.frame.width, height: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: HomePageCLV.frame.width, height: (HomePageCLV.frame.width * 9) / 16)
    }
}

//MARK: - HomePageViewViewProtocol
extension HomePageViewViewController: HomePageViewViewProtocol{
    // TODO: Implement View Output Methods
    func reloadData(_ data: HomePageModel) {
        stopLoadingAnimate()
        dataSource = HomePageViewDataSource(entities: data, with: presenter!)
        HomePageCLV.reloadData()
    }    
}

