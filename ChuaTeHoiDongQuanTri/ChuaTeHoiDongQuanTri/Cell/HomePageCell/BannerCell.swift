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
    var indexPageController = 0
  
    override func awakeFromNib() {
        super.awakeFromNib()
        bannerCLV.registerCell(nibName: ChildCell.self)
        bannerCLV.delegate = self
        bannerCLV.dataSource = self
    }
    
    func configure(data : [RecommendContentVOList]) {
        listDataCall = data
        bannerCLV.reloadData()
    }
}

extension BannerCell {
    @IBAction func next(_ sender : UIButton) {
        if indexPageController >= 0 && indexPageController <= listDataCall.count - 1 {
            indexPageController += 1
            dLogDebug(indexPageController)
            let indexPath = IndexPath(item: indexPageController, section: 0)
            bannerCLV.scrollToItem(at: indexPath, at: .right, animated: true)
        } else {
            indexPageController = 0
            let indexPath = IndexPath(item: indexPageController, section: 0)
            bannerCLV.scrollToItem(at: indexPath, at: .right, animated: true)
        }
    }
    
    @IBAction func back(_ sender : UIButton) {
        if indexPageController < 0 { indexPageController = 0 }
        if indexPageController >= 0 && indexPageController <= listDataCall.count - 1 {
            indexPageController -= 1
            let indexPath = IndexPath(item: indexPageController, section: 0)
            bannerCLV.scrollToItem(at: indexPath, at: .right, animated: true)
        } else {
            indexPageController = 0
            let indexPath = IndexPath(item: indexPageController, section: 0)
            bannerCLV.scrollToItem(at: indexPath, at: .right, animated: true)
        }
    }
}

extension BannerCell : UICollectionViewDelegate {
    
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
