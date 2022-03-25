//
//  MovieCell.swift
//  ChuaTeHoiDongQuanTri
//
//  Created by Valerian on 25/03/2022.
//

import UIKit

class MovieCell: UICollectionViewCell {
    
    @IBOutlet weak var posterImage : UIImageView!
    @IBOutlet weak var titleLabel : UILabel!
    @IBOutlet weak var blurImageView : UIImageView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configure(_ imageURL: String,_ title: String) {
        posterImage.setImage(targetImageView: posterImage, with: imageURL)
        blurImageView.setImage(targetImageView: blurImageView, with: imageURL)
        blurImageView.makeBlurImage(targetImageView: blurImageView)
        titleLabel.text = title
    }
}
