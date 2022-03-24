//
//  MovieHomePage.swift
//  ChuaTeHoiDongQuanTri
//
//  Created by Valerian on 24/02/2022.
//

import UIKit
import Foundation

class MovieHomePage: BaseViewController {
    
    @IBOutlet weak var HomePageCLV: UICollectionView!
    @IBOutlet weak var TopSearchCLV : UICollectionView!
    
    var dataResponse = HomePageModel(fromDictionary: ["" : ""])
    
    var homePagePresentor : HomePagePresenter!
    var index = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpBaseView()
        
        homePagePresentor = HomePagePresenter(view: self)
        homePagePresentor.getHomePageData(page: index)
        
        APIService.shared.getReviewMedia(by: 0) { response, error in
            if let response = response {
                dLogDebug(response)
            }
        }
    
        //CELL
        HomePageCLV.registerCell(nibName: BannerCell.self)
        HomePageCLV.registerCell(nibName: CategoryCell.self)
        HomePageCLV.registerCellForHeader(nibName: MainHeader.self)
        HomePageCLV.registerCellForFooter(nibName: MainFooter.self)
        
        TopSearchCLV.registerCell(nibName: TopSearchCell.self)
        TopSearchCLV.registerCellForHeader(nibName: MainHeader.self)
    }
}

extension MovieHomePage: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if indexPath.section == 0 {
            // handle item in section = 0
        }
        
        if collectionView == TopSearchCLV {
            if let id = Int(homePagePresentor.getTopSearchData()[indexPath.row].id),
               let category = homePagePresentor.getTopSearchData()[indexPath.row].domainType {
                homePagePresentor.getMovieDetail(id, category)
            }
        } else {
            if let id = homePagePresentor.listResponseData.recommendItems[indexPath.section].recommendContentVOList[indexPath.row].id,
               let category = homePagePresentor.listResponseData.recommendItems[indexPath.section].recommendContentVOList[indexPath.row].category {
                homePagePresentor.getMovieDetail(id, category)
            }
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
        if collectionView == TopSearchCLV {
            return 1
        }
        return homePagePresentor.getData().recommendItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == TopSearchCLV {
            return homePagePresentor.getTopSearchData().count
        }
        
        if section == 0 {
            return 1
        }
        return homePagePresentor.getData().recommendItems[section].recommendContentVOList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == TopSearchCLV {
            let cell = collectionView.dequeue(cellClass: TopSearchCell.self, forIndexPath: indexPath)
            cell.configure(homePagePresentor.getTopSearchData()[indexPath.row].cover, homePagePresentor.getTopSearchData()[indexPath.row].title)
            return cell
        }
        
        let imageURL = homePagePresentor.getData().recommendItems[indexPath.section].recommendContentVOList[indexPath.row].imageUrl ?? ""
        let title = homePagePresentor.getData().recommendItems[indexPath.section].recommendContentVOList[indexPath.row].title ?? ""
        
        if homePagePresentor.getData().recommendItems[indexPath.section].homeSectionType == "BANNER" {
            let cell = collectionView.dequeue(cellClass: BannerCell.self, forIndexPath: indexPath)
            cell.configure(data: homePagePresentor.getData().recommendItems[0].recommendContentVOList)
            return cell
        }
        
        let cell = collectionView.dequeue(cellClass: CategoryCell.self, forIndexPath: indexPath)
        cell.configure(imageURL, title)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            if collectionView == TopSearchCLV {
                let header = collectionView.dequeueHeader(cellClass: MainHeader.self, OfKind: UICollectionView.elementKindSectionHeader, forIndexPath: indexPath)
                header.configure("Top Searches")
                return header
            }
            let header = collectionView.dequeueHeader(cellClass: MainHeader.self, OfKind: UICollectionView.elementKindSectionHeader, forIndexPath: indexPath)
            header.configure(homePagePresentor.getData().recommendItems[indexPath.section].homeSectionName)
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
        if collectionView == TopSearchCLV {
            return CGSize(width: TopSearchCLV.frame.width, height: 70)
        } else if homePagePresentor.getData().recommendItems[section].homeSectionType == "BANNER" {
            return CGSize(width: HomePageCLV.frame.width, height: 0)
        }
        return CGSize(width: HomePageCLV.frame.width, height: 70)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if collectionView == TopSearchCLV {
            return CGSize(width: TopSearchCLV.frame.width, height: 0)
        }
        return CGSize(width: HomePageCLV.frame.width, height: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == TopSearchCLV {
            return CGSize(width: TopSearchCLV.frame.width, height: 70)
        } else if homePagePresentor.getData().recommendItems[indexPath.section].homeSectionType == "BANNER" {
            return CGSize(width: HomePageCLV.frame.width, height: HomePageCLV.frame.height / 2)
        }
        return CGSize(width: (HomePageCLV.frame.width - 40) / 4, height: HomePageCLV.frame.height / 3)
    }
    
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        UIView.animate(withDuration: 0.4) {
            if let cell = collectionView.cellForItem(at: indexPath) as? CategoryCell {
                cell.posterImage.transform = .init(scaleX: 0.75, y: 0.75)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        UIView.animate(withDuration: 0.5) {
            if let cell = collectionView.cellForItem(at: indexPath) as? CategoryCell {
                cell.posterImage.transform = .identity
            }
        }
    }
}

extension MovieHomePage : UpdateHomePageDelegate {
    func responseMovieDetail() {
        DispatchQueue.main.async { [weak self] in
            guard let _self = self else { return }
            let detailVC = MovieDetailVC(_self.homePagePresentor.getMovieDetail())
            _self.navigationController?.pushViewController(detailVC, animated: true)
        }
    }
    
    func updateUI() {
        DispatchQueue.main.async { [weak self] in
            guard let _self = self else { return }
            _self.stopLoadingAnimate()
            _self.HomePageCLV.reloadData()
            _self.TopSearchCLV.reloadData()
        }
    }
}
