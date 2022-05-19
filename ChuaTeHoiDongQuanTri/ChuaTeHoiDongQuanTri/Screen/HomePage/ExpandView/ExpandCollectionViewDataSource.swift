//
//  ExpandCollectionViewDataSource.swift
//  ChuaTeHoiDongQuanTri
//
//  Created by Valerian on 31/03/2022.
//

import Foundation
import UIKit


class ExpandCollectionViewDataSource : CollectionviewDataSource {

    private var entities = RecommendItem(fromDictionary: ["" : ""])
    private weak var presenter: ExpandScreenPresenterProtocol?
    
    init(entities: RecommendItem,with  presenter: ExpandScreenPresenterProtocol) {
        self.entities = entities
        self.presenter = presenter
    }
    
    var numberOfItems: Int {
        return entities.recommendContentVOList.count
    }
    
    func itemCell(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        if let imageUrl = entities.recommendContentVOList[indexPath.row].imageUrl, let titleLabel = entities.recommendContentVOList[indexPath.row].title {
            let cell = collectionView.dequeue(cellClass: MovieCell.self, forIndexPath: indexPath)
            cell.configure(imageUrl, titleLabel)
            return cell
        }
        return UICollectionViewCell()
    }
    
    func didSelect(indexPath: Int) {
        presenter?.openDetailView(id: entities.recommendContentVOList[indexPath].id, category: entities.recommendContentVOList[indexPath].category)
    }
    
    func sizeForItem(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let widther = collectionView.frame.width / 3
        let heigher = widther * 7 / 5
        return CGSize(width: widther - 10, height: heigher + 30)
    }
    
    func prefetchingData(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
    }
}
