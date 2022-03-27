//
//  MainHeader.swift
//  ChuaTeHoiDongQuanTri
//
//  Created by Valerian on 20/02/2022.
//

import UIKit

class MainHeader: UICollectionReusableView {
    
    @IBOutlet weak var mainTitle : UILabel!
    @IBOutlet weak var expandButton : UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(_ title: String) {
        mainTitle.textColor = .black
        mainTitle.text = title
    }

    func disableExpandButton() {
        expandButton.isHidden = true
    }
}
