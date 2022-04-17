//
//  DiscoveryCatagoryCLVCell.swift
//  ChuTeHoiDongQuanTri
//
//  Created by admin on 08/04/2022.
//

import UIKit

class DiscoveryCatagoryCLVCell: UICollectionViewCell {

    @IBOutlet weak var chooseView: UIView!
    @IBOutlet weak var catagoryLabel: UILabel!
    var item : DiscoveryItem? {
        didSet {
            guard let data = item else { return }
            self.config(with: data)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.catagoryLabel.text = "abc"
    }
    
    private func config(with data: DiscoveryItem) {
        self.catagoryLabel.text = data.name
        if data.isSelected {
            self.chooseView.backgroundColor = .lightGray
        } else {
            self.chooseView.backgroundColor = .clear
        }
    }
}
