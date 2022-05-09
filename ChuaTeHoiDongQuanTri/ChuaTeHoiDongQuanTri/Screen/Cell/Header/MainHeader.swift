//
//  MainHeader.swift
//  ChuaTeHoiDongQuanTri
//
//  Created by Valerian on 20/02/2022.
//

import UIKit

protocol HandleTapHeaderProtocol: AnyObject {
    func tap()
}

class MainHeader: UICollectionReusableView {
    
    @IBOutlet weak var mainTitle : UILabel!
    @IBOutlet weak var expandButton : UIButton!
    
    var tapDelegate: HandleTapHeaderProtocol?

    override func awakeFromNib() {
        super.awakeFromNib()
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapHeader)))
    }
    
    func configure(_ title: String) {
        mainTitle.textColor = .black
        mainTitle.text = title
    }

    func disableExpandButton() {
        expandButton.isHidden = true
    }
    
    @objc func tapHeader() {
        tapDelegate?.tap()
    }
}
