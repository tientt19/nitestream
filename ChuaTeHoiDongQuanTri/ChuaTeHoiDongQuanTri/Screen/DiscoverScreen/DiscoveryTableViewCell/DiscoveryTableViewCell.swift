//
//  DiscoveryTableViewCell.swift
//  ChuTeHoiDongQuanTri
//
//  Created by admin on 08/04/2022.
//

import UIKit

class DiscoveryTableViewCell: UITableViewCell {

    @IBOutlet weak var acollectionView: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        registerCell()
    }
    
    private func registerCell() {
        self.acollectionView.registerCell(nibName: DiscoveryCatagoryCLVCell.self)
        self.acollectionView.delegate = self
        self.acollectionView.dataSource = self
    }
}

//MARK: - UICollectionViewDelegate
extension DiscoveryTableViewCell: UICollectionViewDelegate {
    
}

//MARK: - UICollectionViewDataSource
extension DiscoveryTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = acollectionView.dequeue(cellClass: DiscoveryCatagoryCLVCell.self, forIndexPath: indexPath)
        return cell
    }
    
    
}

//MARK: - UICollectionViewDelegateFlowLayout
extension DiscoveryTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: self.frame.height)
    }
}
