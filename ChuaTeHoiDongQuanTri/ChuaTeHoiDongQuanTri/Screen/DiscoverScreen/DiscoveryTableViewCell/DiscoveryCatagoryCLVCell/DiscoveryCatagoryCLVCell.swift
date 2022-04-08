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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.catagoryLabel.text = "abc"
        self.chooseView.backgroundColor = .lightGray
    }

}
