//
//  SearchingIGListKitCell.swift
//  ChuTeHoiDongQuanTri
//
//  Created by Valerian on 05/05/2022.
//

import UIKit


protocol ConfigureDataPrototcol: AnyObject {
    func update(_ imageURL : String,_ movieName : String)
}

class SearchingIGListKitCell: UICollectionViewCell {
    @IBOutlet weak var posterImage : UIImageView!
    @IBOutlet weak var name : UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}

extension SearchingIGListKitCell: ConfigureDataPrototcol {
    func update(_ imageURL: String, _ movieName: String) {
        self.posterImage.setImageCachingv2(targetImageView: self.posterImage, with: imageURL)
        self.name.text = movieName
    }
}


