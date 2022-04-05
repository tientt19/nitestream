//
//  tiktokTableViewCell.swift
//  ChuTeHoiDongQuanTri
//
//  Created by Valerian on 04/04/2022.
//

import UIKit
import StreamingTienPro

class tiktokTableViewCell: UITableViewCell {
    
    @IBOutlet weak var mediaPlayerView : UIView!
    @IBOutlet weak var posterImamge : UIImageView!
    @IBOutlet weak var titleLabel : UILabel!
    @IBOutlet weak var scoreLabel : UILabel!
    @IBOutlet weak var tagListView : TagListView!
    
    var moviePlayer = MovieStreaming()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func playMedia(link: String) {
        self.moviePlayer.configure(in: self.mediaPlayerView)
        if let linkMedia = URL(string: link) {
            self.moviePlayer.streaming(with: linkMedia, subRemote: "okokok")
        }
    }
    
    func configure(data : ReviewMedia) {
        posterImamge.setImageCachingv2(targetImageView: posterImamge, with: data.refList[0].coverVerticalUrl ?? "")
        titleLabel.text = data.introduction
        scoreLabel.text = "\(String(describing: data.refList[0].score ?? 0))"
        tagListView.textFont = UIFont.systemFont(ofSize: 12)
        tagListView.addTags(data.refList[0].tagList.map { $0.name })
    }
}
