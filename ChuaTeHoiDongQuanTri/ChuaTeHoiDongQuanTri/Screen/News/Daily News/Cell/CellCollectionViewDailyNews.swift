//
//  CellCollectionViewDailyNews.swift
//  ChuTeHoiDongQuanTri
//
//  Created by Valerian on 04/06/2022.
//

import UIKit

class CellCollectionViewDailyNews: UICollectionViewCell {
    
    @IBOutlet weak var lbl_title: UILabel!
    @IBOutlet weak var lbl_recommendation: UILabel!
    @IBOutlet weak var lbl_createdAt: UILabel!
    @IBOutlet weak var img_coverImage: UIImageView!
    
    var model: NewsModel? {
        didSet {
            if let data = model {
                self.config(with: data)
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func config(with data: NewsModel) {
        self.img_coverImage.setImageCachingv2(targetImageView: self.img_coverImage, with: data.coverImg ?? "")
        self.lbl_title.text = data.title
        let dateFormatter = DateFormatter()
        let epochTime = TimeInterval(data.createTime ?? 0) / 1000
        let date = Date(timeIntervalSince1970: epochTime)
        dateFormatter.dateFormat = "yyyy-MM-dd" //Specify your format that you want
        self.lbl_createdAt.text = dateFormatter.string(from: date)
        self.lbl_recommendation.text = data.introduction
    }
}
