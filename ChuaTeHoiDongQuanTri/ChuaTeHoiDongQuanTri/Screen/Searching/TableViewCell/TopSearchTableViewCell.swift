//
//  TopSearchTableViewCell.swift
//  ChuaTeHoiDongQuanTri
//
//  Created by Valerian on 28/03/2022.
//

import UIKit

class TopSearchTableViewCell: UITableViewCell {
    
    @IBOutlet weak var posterImage : UIImageView!
    @IBOutlet weak var name : UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(_ imageURL : String,_ movieName : String) {
        posterImage.setImageCaching(targetImageView: posterImage, with: imageURL)
        name.text = movieName
    }
    
}
