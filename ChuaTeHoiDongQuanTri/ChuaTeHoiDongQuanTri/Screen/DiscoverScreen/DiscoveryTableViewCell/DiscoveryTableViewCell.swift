//
//  DiscoveryTableViewCell.swift
//  ChuTeHoiDongQuanTri
//
//  Created by admin on 08/04/2022.
//

import UIKit

class DiscoveryTableViewCell: UITableViewCell {

    
    @IBOutlet weak var acollectionView: UICollectionView!
    var model: ScreeningItems? {
        didSet {
            self.acollectionView.reloadData()
        }
    }
    
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
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let data = self.model?.items else { return }
        for item in data {
            item.isSelected = false
        }
        data[indexPath.row].isSelected = true

        DispatchQueue.main.async {
            self.acollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            self.acollectionView.reloadData()
        }
    }
    
}

//MARK: - UICollectionViewDataSource
extension DiscoveryTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let data = self.model else {
            return 0
        }
        guard let items = data.items else { return 0}
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = acollectionView.dequeue(cellClass: DiscoveryCatagoryCLVCell.self, forIndexPath: indexPath)
        guard let data = self.model?.items else { return cell }
        cell.item = data[indexPath.row]
        return cell
    }
    
    
}

//MARK: - UICollectionViewDelegateFlowLayout
extension DiscoveryTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let data = self.model?.items else { return CGSize(width: 0, height: self.frame.height) }
        let labelCount = data[indexPath.row].name?.count ?? 0
        let width: CGFloat = CGFloat(10 * labelCount + 8 * 2)
        return CGSize(width: width, height: self.frame.height)
    }
}
