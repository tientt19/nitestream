//
//  HomePageViewDatasource.swift
//  ChuaTeHoiDongQuanTri
//
//  Created by Valerian on 01/04/2022.
//

import Foundation
import UIKit

class HomePageViewDataSource : HomePageViewDataSourceProtocol {

    private var entities = HomePageModel(fromDictionary: ["" : ""])
    private weak var presenter: HomePageViewPresenterProtocol?
    
    init(entities: HomePageModel,with  presenter: HomePageViewPresenterProtocol) {
        self.entities = entities
        self.presenter = presenter
    }
    
    var numberOfItems: Int {
        return entities.recommendItems.count
    }
    
    func itemCell(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        if entities.recommendItems[indexPath.section].homeSectionType == "BANNER" {
            let cell = collectionView.dequeue(cellClass: BannerCell.self, forIndexPath: indexPath)
            cell.configure(data: entities.recommendItems[0].recommendContentVOList)
            return cell
        }
        
        let cell = collectionView.dequeue(cellClass: CategoryCell.self, forIndexPath: indexPath)
        cell.sendDelegate = presenter as? passDataPickDelegate
//        cell.configure(data: entities.recommendItems[indexPath.section].recommendContentVOList)
//        if entities.recommendItems[indexPath.section].homeSectionType == "BLOCK_GROUP" { cell.isGroupBlock = true }
        return cell
    }
    
    func didSelect(collectionView: UICollectionView, indexPath: IndexPath) {
        
    }
    
    func loadMore(_ page: Int) {
        presenter?.loadMore(page, listData())
    }
    
    func listData() -> HomePageModel {
        return entities
    }
    
    func itemHeaderCell(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let header = collectionView.dequeueHeader(cellClass: MainHeader.self, OfKind: UICollectionView.elementKindSectionHeader, forIndexPath: indexPath)
            let sectionName = entities.recommendItems[indexPath.section].homeSectionName
            let sectionType = entities.recommendItems[indexPath.section].homeSectionType
            header.configure(sectionName ?? "")
            if sectionType == "BLOCK_GROUP" {
                header.disableExpandButton()
            } else {
                header.expandButton.isHidden = false
            }
            return header
        case UICollectionView.elementKindSectionFooter:
            let footer = collectionView.dequeueFooter(cellClass: MainFooter.self, OfKind: UICollectionView.elementKindSectionFooter, forIndexPath: indexPath)
            return footer
        default:
            assert(false, "Unexpected element kind")
        }
    }
    
    func prefetchingData(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        
    }
}
