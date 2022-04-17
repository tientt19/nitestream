//
//  ListSearchResultTableViewCell.swift
//  ChuTeHoiDongQuanTri
//
//  Created by Valerian on 16/04/2022.
//

import UIKit

class ListSearchResultTableViewCell: UITableViewCell {
    
    @IBOutlet weak var clv_tvSeries : UICollectionView!
    
    var model: [SearchResult]? {
        didSet {
            self.clv_tvSeries.reloadData()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        registerCell()
    }
    
    private func registerCell() {
        self.clv_tvSeries.registerCell(nibName: MovieCell.self)
        self.clv_tvSeries.delegate = self
        self.clv_tvSeries.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}

//MARK: - UICollectionViewDelegate
extension ListSearchResultTableViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

//MARK: - UICollectionViewDataSource
extension ListSearchResultTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let data = self.model else {
            return 0
        }
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = clv_tvSeries.dequeue(cellClass: MovieCell.self, forIndexPath: indexPath)
        guard let data = self.model else { return cell }
        cell.configure(data[indexPath.row].coverVerticalUrl, data[indexPath.row].name)
        return cell
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension ListSearchResultTableViewCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat { return 5 }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat { return 5 }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let _ = self.model else { return CGSize(width: 0, height: self.frame.height) }
        let widther = collectionView.frame.width / 3
        let heigher = widther * 7 / 5
        return CGSize(width: widther - 10, height: heigher + 30)
    }
}
