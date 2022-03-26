//
//  MovieHomePage.swift
//  ChuaTeHoiDongQuanTri
//
//  Created by Valerian on 24/02/2022.
//

import UIKit
import Foundation
import CoreMedia

class MovieHomePage: BaseViewController {
    
    @IBOutlet weak var HomePageCLV: UICollectionView!
    
    var dataResponse = HomePageModel(fromDictionary: ["" : ""])
    var sendDataToExpand = RecommendItem(fromDictionary: ["" :  ""])
    
    var homePagePresentor : HomePagePresenter!
    var index = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpBaseView()
        
        homePagePresentor = HomePagePresenter(view: self)
        homePagePresentor.getHomePageData(page: index)
    
        //CELL
        HomePageCLV.registerCell(nibName: BannerCell.self)
        HomePageCLV.registerCell(nibName: CategoryCell.self)
        HomePageCLV.registerCellForHeader(nibName: MainHeader.self)
        HomePageCLV.registerCellForFooter(nibName: MainFooter.self)
        
    }
    
    @objc func handleTapGuesture() {
        let expandVC = ExpandViewControler(data: sendDataToExpand)
        expandVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(expandVC, animated: true)
    }
}

extension MovieHomePage: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if indexPath.section == 0 {
            // handle item in section = 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.section == homePagePresentor.getData().recommendItems.count - 2 {
            activityIndicatorView.startAnimating()
            index += 1
            homePagePresentor.loadMore(page: index)
        }
    }
}

extension MovieHomePage: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return homePagePresentor.getData().recommendItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if homePagePresentor.getData().recommendItems[indexPath.section].homeSectionType == "BANNER" {
            let cell = collectionView.dequeue(cellClass: BannerCell.self, forIndexPath: indexPath)
            cell.configure(data: homePagePresentor.getData().recommendItems[0].recommendContentVOList)
            return cell
        }
        
        let cell = collectionView.dequeue(cellClass: CategoryCell.self, forIndexPath: indexPath)
        cell.sendDelegate = self
        cell.configure(data: homePagePresentor.getData().recommendItems[indexPath.section].recommendContentVOList)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let header = collectionView.dequeueHeader(cellClass: MainHeader.self, OfKind: UICollectionView.elementKindSectionHeader, forIndexPath: indexPath)
            header.configure(homePagePresentor.getData().recommendItems[indexPath.section].homeSectionName)
            sendDataToExpand = homePagePresentor.getData().recommendItems[indexPath.section]
            let tap = UITapGestureRecognizer(target: self,action: #selector(self.handleTapGuesture))
            header.addGestureRecognizer(tap)
            return header
        case UICollectionView.elementKindSectionFooter:
            let footer = collectionView.dequeueFooter(cellClass: MainFooter.self, OfKind: UICollectionView.elementKindSectionFooter, forIndexPath: indexPath)
            return footer
        default:
            assert(false, "Unexpected element kind")
        }
    }
}

extension MovieHomePage: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if homePagePresentor.getData().recommendItems[section].homeSectionType == "BANNER" {
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

extension MovieHomePage : UpdateHomePageDelegate {
    func responseMovieDetail() {
        DispatchQueue.main.async { [weak self] in
            guard let _self = self else { return }
            let detailVC = MovieDetailVC(_self.homePagePresentor.getMovieDetail())
            detailVC.hidesBottomBarWhenPushed = true
            _self.navigationController?.pushViewController(detailVC, animated: true)
        }
    }
    
    func updateUI() {
        DispatchQueue.main.async { [weak self] in
            guard let _self = self else { return }
            _self.stopLoadingAnimate()
            _self.HomePageCLV.reloadData()
        }
    }
}

extension MovieHomePage : passDataPickDelegate {
    func openDetailView(_ data: RecommendContentVOList) {
        if let id = data.id, let category = data.category {
            homePagePresentor.getMovieDetail(id, category)
        }
    }
}
