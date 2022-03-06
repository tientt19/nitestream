//
//  ChildCell.swift
//  ChuaTeHoiDongQuanTri
//
//  Created by Valerian on 25/02/2022.
//

import UIKit

class ChildCell: UICollectionViewCell {
    
    @IBOutlet weak var bannerImageView : UIImageView!
    @IBOutlet weak var titleLabel : UILabel!
    
    var dataPassed = DataModel(id: "", category: 0, name: "", coverHorizontalUrl: "")

    override func awakeFromNib() {
        super.awakeFromNib()
       
    }
    
    func configure(_ imageURL : String, _ title: String) {
        bannerImageView.setImage(targetImageView: bannerImageView, with: imageURL)
        titleLabel.text = title
    }
    
    func configure(data: DataModel) {
        self.dataPassed = data
        bannerImageView.setImage(targetImageView: bannerImageView, with: data.coverHorizontalUrl)
        titleLabel.text = data.name
    }
}
