//
//  BannerCell.swift
//  ChuaTeHoiDongQuanTri
//
//  Created by Valerian on 24/02/2022.
//

import UIKit
import Kingfisher

protocol BannerTapDelegate: AnyObject {
    func onDidselect(with model: HomeBannerModels)
}

class BannerCell: UICollectionViewCell{
  
    @IBOutlet weak var bannerCLV: UICollectionView!
    @IBOutlet weak var pageView : UIPageControl!
    var delegate: BannerTapDelegate?
    
    var listDataCall = [HomeBannerModels]()
    var timer = Timer()
    var counter = 0
    
    var model: [HomeBannerModels]? {
        didSet {
            if let data = model {
                self.config(with: data)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        bannerCLV.registerCell(nibName: ChildCell.self)
        bannerCLV.delegate = self
        bannerCLV.dataSource = self
        configAutoscrollTimer()
    }
    
    func configure(data : [RecommendContentVOList]) {
//        listDataCall = data
        pageView.numberOfPages = listDataCall.count
        pageView.currentPage = 0
        bannerCLV.reloadData()
    }
    
    func config(with data: [HomeBannerModels]) {
        self.listDataCall = data
        self.pageView.numberOfPages = self.listDataCall.count
        self.pageView.currentPage = 0
        self.bannerCLV.reloadData()
    }
}

extension BannerCell : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegate?.onDidselect(with: self.listDataCall[indexPath.row])
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
        let imageUrl = listDataCall[indexPath.row].imgUrl ?? ""
        let titleLabel = listDataCall[indexPath.row].title ?? ""
        
        let cell = collectionView.dequeue(cellClass: ChildCell.self, forIndexPath: indexPath)
        cell.configure(imageUrl, titleLabel)
        return cell
    }
}

extension BannerCell {
    func configAutoscrollTimer() {
        DispatchQueue.main.async {
            self.timer = Timer.scheduledTimer(timeInterval: 1.5, target: self, selector: #selector(self.changeImage), userInfo: nil, repeats: true)
        }
    }
    
    @objc func changeImage() {
        if counter < listDataCall.count {
            let index = IndexPath.init(item: counter, section: 0)
            self.bannerCLV.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
            pageView.currentPage = counter
            counter += 1
        } else {
            counter = 0
            let index = IndexPath.init(item: counter, section: 0)
            self.bannerCLV.scrollToItem(at: index, at: .centeredHorizontally, animated: false)
            pageView.currentPage = counter
            counter = 1
        }
    }
}
