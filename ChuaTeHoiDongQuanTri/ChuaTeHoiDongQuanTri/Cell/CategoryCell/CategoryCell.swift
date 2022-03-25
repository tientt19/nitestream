//
//  CategoryCell.swift
//  ChuaTeHoiDongQuanTri
//
//  Created by Valerian on 25/02/2022.
//

import UIKit

class CategoryCell: UICollectionViewCell {
    
    @IBOutlet weak var CategoryCollectionView : UICollectionView!
    var listDataCall = [RecommendContentVOList]()

    override func awakeFromNib() {
        super.awakeFromNib()
        CategoryCollectionView.registerCell(nibName: MovieCell.self)
        CategoryCollectionView.delegate = self
        CategoryCollectionView.dataSource = self
    }
    
    func configure(data : [RecommendContentVOList]) {
        listDataCall = data
        CategoryCollectionView.reloadData()
    }
}

extension CategoryCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: CategoryCollectionView.frame.width / 3, height: CategoryCollectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}

extension CategoryCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listDataCall.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let imageUrl = listDataCall[indexPath.row].imageUrl, let titleLabel = listDataCall[indexPath.row].title {
            let cell = collectionView.dequeue(cellClass: MovieCell.self, forIndexPath: indexPath)
            cell.configure(imageUrl, titleLabel)
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

