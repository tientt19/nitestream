//
//  CategoryCell.swift
//  ChuaTeHoiDongQuanTri
//
//  Created by Valerian on 25/02/2022.
//

import UIKit

protocol passDataPickDelegate: AnyObject {
    func openDetailView(_ data: RecommendContentVOList)
}

class CategoryCell: UICollectionViewCell {
    
    @IBOutlet weak var CategoryCollectionView : UICollectionView!
    var listDataCall = [RecommendContentVOList]()
    var isGroupBlock = false
    
    var sendDelegate : passDataPickDelegate!

    override func awakeFromNib() {
        super.awakeFromNib()
        CategoryCollectionView.registerCell(nibName: MovieCell.self)
        CategoryCollectionView.delegate = self
        CategoryCollectionView.dataSource = self
        CategoryCollectionView.prefetchDataSource = self
    }
    
    func configure(data : [RecommendContentVOList]) {
        listDataCall = data
        CategoryCollectionView.reloadData()
    }
}

//MARK: - UICollectionViewDataSourcePrefetching
extension CategoryCell: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            if let prefetchingCell = collectionView.cellForItem(at: indexPath) as? MovieCell {
                if let imageUrl = listDataCall[indexPath.row].imageUrl, let titleLabel = listDataCall[indexPath.row].title {
                    prefetchingCell.configure(imageUrl, titleLabel)
                    if isGroupBlock { prefetchingCell.configureForGroupBlock() }
                }
            }
        }
    }
}

//MARK: - UICollectionViewDelegate
extension CategoryCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        sendDelegate.openDetailView(listDataCall[indexPath.item])
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension CategoryCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let widther = CategoryCollectionView.frame.width / 3
        let heigher = widther * 7 / 5
        return CGSize(width: widther, height: heigher + 30)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}

//MARK: - UICollectionViewDataSource
extension CategoryCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listDataCall.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let imageUrl = listDataCall[indexPath.row].imageUrl, let titleLabel = listDataCall[indexPath.row].title {
            let cell = collectionView.dequeue(cellClass: MovieCell.self, forIndexPath: indexPath)
            cell.configure(imageUrl, titleLabel)
            if isGroupBlock { cell.configureForGroupBlock() }
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        UIView.animate(withDuration: 0.4) {
            if let cell = collectionView.cellForItem(at: indexPath) as? MovieCell {
                cell.posterImage.transform = .init(scaleX: 0.75, y: 0.75)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        UIView.animate(withDuration: 0.5) {
            if let cell = collectionView.cellForItem(at: indexPath) as? MovieCell {
                cell.posterImage.transform = .identity
            }
        }
    }
}

