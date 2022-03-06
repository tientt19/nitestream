//
//  CategoryCell.swift
//  ChuaTeHoiDongQuanTri
//
//  Created by Valerian on 25/02/2022.
//

import UIKit

class CategoryCell: UICollectionViewCell {
    
    @IBOutlet weak var posterImage : UIImageView!
    @IBOutlet weak var titleLabel : UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
     
    }
    
    func configure(_ imageURL: String,_ title: String) {
        posterImage.setImage(targetImageView: posterImage, with: imageURL)
        titleLabel.text = title
    }
}

