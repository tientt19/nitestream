//
//  ListInfoCell.swift
//  ChuaTeHoiDongQuanTri
//
//  Created by Valerian on 27/02/2022.
//

import UIKit

class ListInfoCell: UICollectionViewCell {
    
    @IBOutlet weak var content : UILabel!
    
    var dataPassed = EpisodeVo(fromDictionary: ["" : ""])

    override func awakeFromNib() {
        super.awakeFromNib()
      
    }
    
    func configure(_ episode: EpisodeVo) {
        if let contenta = episode.seriesNo {
            content.text = "\(contenta)"
            self.dataPassed = episode
        }
    }
}
