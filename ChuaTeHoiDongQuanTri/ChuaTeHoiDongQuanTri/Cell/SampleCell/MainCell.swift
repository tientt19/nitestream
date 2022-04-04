//
//  MainCell.swift
//  ChuaTeHoiDongQuanTri
//
//  Created by Valerian on 20/02/2022.
//

import UIKit
import Kingfisher

class MainCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView : UIImageView!
    @IBOutlet weak var titleOfPhoto : UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .brown
        self.layer.cornerRadius = 6
    }
    
    func configure(_ data : MainModel) {
        self.imageView.setImageCachingv2(targetImageView: self.imageView, with: data.url)
        self.titleOfPhoto.text = data.title
    }
}
