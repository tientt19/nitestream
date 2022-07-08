//
//  CategoryCell.swift
//  ChuaTeHoiDongQuanTri
//
//  Created by Valerian on 25/02/2022.
//

import UIKit

protocol passDataPickDelegate: AnyObject {
    func openDetailView(_ data: RecommendContentVOListModel)
    func openAlmbumDetaik(with refID: Int?)
}
class CategoryCell: UICollectionViewCell {

    @IBOutlet weak var CategoryCollectionView : UICollectionView!
    @IBOutlet weak var lbl_header: UILabel!
    
    var isGroupBlock = false
    var listDataCall = [RecommendContentVOListModel]()
    var sendDelegate : passDataPickDelegate!
    var model: RecommendItemModel?

    override func awakeFromNib() {
        super.awakeFromNib()
        CategoryCollectionView.registerNib(ofType: MovieCell.self)
        CategoryCollectionView.delegate = self
        CategoryCollectionView.dataSource = self
    }
    
    func configure(data : [RecommendContentVOListModel]) {
        listDataCall = data
        CategoryCollectionView.reloadData()
    }
    
    @IBAction func onExpandTap(_ sender: UIButton) {
        self.sendDelegate.openAlmbumDetaik(with: self.model?.refID)
    }
}

//MARK: - UICollectionViewDelegate
extension CategoryCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.sendDelegate.openDetailView(listDataCall[indexPath.item])
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
            let cell = collectionView.dequeuCell(ofType: MovieCell.self, for: indexPath)
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

