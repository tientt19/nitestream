//
//  BannerCell.swift
//  ChuaTeHoiDongQuanTri
//
//  Created by Valerian on 24/02/2022.
//

import UIKit
import Kingfisher

class BannerCell: UICollectionViewCell {
    
    @IBOutlet weak var bannerCLV: UICollectionView!
    
    var listDataCall = [RecommendContentVOList]()
  
    override func awakeFromNib() {
        super.awakeFromNib()
        bannerCLV.registerCell(nibName: ChildCell.self)
        bannerCLV.delegate = self
        bannerCLV.dataSource = self
        bannerCLV.prefetchDataSource = self
    }
    
    func configure(data : [RecommendContentVOList]) {
        listDataCall = data
        bannerCLV.reloadData()
    }
}

extension BannerCell : UICollectionViewDelegate {
    
}

extension BannerCell: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            if let prefetchingCell = collectionView.cellForItem(at: indexPath) as? ChildCell {
                let imageUrl = listDataCall[indexPath.row].imageUrl ?? ""
                let titleLabel = listDataCall[indexPath.row].title ?? ""
                prefetchingCell.configure(imageUrl, titleLabel)
            }
        }
    }
}


extension BannerCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: bannerCLV.frame.width, height: bannerCLV.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

extension BannerCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listDataCall.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let imageUrl = listDataCall[indexPath.row].imageUrl ?? ""
        let titleLabel = listDataCall[indexPath.row].title ?? ""
        let cell = collectionView.dequeue(cellClass: ChildCell.self, forIndexPath: indexPath)
        cell.configure(imageUrl, titleLabel)
        return cell
    }
}
