//
//  MainHeader.swift
//  ChuaTeHoiDongQuanTri
//
//  Created by Valerian on 20/02/2022.
//

import UIKit

class MainHeader: UICollectionReusableView {
    
    @IBOutlet weak var mainTitle : UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(_ title: String) {
        mainTitle.text = title
    }
}
