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
    @IBOutlet weak var img_coverImage: UIImageView!
    @IBOutlet weak var view_TagListView: TagListView!
    
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
        self.view_TagListView.addTags(data.keyword ?? [""])
        self.lbl_recommendation.text = data.introduction
    }
}
