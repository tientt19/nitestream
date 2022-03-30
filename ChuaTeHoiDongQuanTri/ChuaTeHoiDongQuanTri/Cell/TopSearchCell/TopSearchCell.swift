//
//  TopSearchCell.swift
//  ChuaTeHoiDongQuanTri
//
//  Created by Valerian on 26/02/2022.
//

import UIKit

class TopSearchCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView : UIImageView!
    @IBOutlet weak var movieName : UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(_ imageURL : String,_ name : String) {
        imageView.setImageCaching(targetImageView: imageView, with: imageURL)
        movieName.text = name
    }

}
