//
//  HorizontallyCell.swift
//  ChuaTeHoiDongQuanTri
//
//  Created by Valerian on 02/03/2022.
//

import UIKit

protocol triggerCellDelegate {
    func trigger(dataPassed : DataModel)
}

class HorizontallyCell: UICollectionViewCell {
    
    @IBOutlet weak var childCLV: UICollectionView!
    
    var delegate : triggerCellDelegate!
    var data = [DataModel]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        childCLV.registerCell(nibName: ChildCell.self)
        childCLV.delegate = self
        childCLV.dataSource = self
    }

    func configure(data : [DataModel]) {
        self.data = data
        childCLV.reloadData()
    }
}

extension HorizontallyCell : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let selectedCell = collectionView.cellForItem(at: indexPath) as? ChildCell {
            delegate.trigger(dataPassed: selectedCell.dataPassed)
        }
    }
}

extension HorizontallyCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: childCLV.frame.width / 8, height: childCLV.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}

extension HorizontallyCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeue(cellClass: ChildCell.self, forIndexPath: indexPath)
        cell.configure(data: data[indexPath.row])
        return cell
    }
}
