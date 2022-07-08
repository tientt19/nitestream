//
//  ShortVideoCollectionCell.swift
//  ChuTeHoiDongQuanTri
//
//  Created by Valerian on 31/05/2022.
//

import UIKit
import StreamingTienPro

class ShortVideoCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var mediaPlayerView : UIView!
    @IBOutlet weak var posterImamge : UIImageView!
    @IBOutlet weak var titleLabel : UILabel!
    @IBOutlet weak var scoreLabel : UILabel!
    @IBOutlet weak var likeCount : UILabel!
    @IBOutlet weak var tagListView : TagListView!
    @IBOutlet weak var tiktokInfo : UIView!
    
    var moviePlayer = MovieStreaming()

    override func awakeFromNib() {
        super.awakeFromNib()
        NotificationCenter.default.addObserver(self, selector: #selector(stopPlayingMedia), name: .stopPlayingMedia, object: nil)
    }
    
    func configure(link: String, data : ReviewShortVideoModel) {
        self.moviePlayer.configure(in: self.mediaPlayerView)
        if let linkMedia = URL(string: link) {
            self.moviePlayer.streamingShortVideo(with: linkMedia)
        }
        self.tagListView.removeAllTags()
        self.posterImamge.setImageCachingv2(targetImageView: posterImamge, with: data.refList?.first?.coverVerticalURL ?? "")
        self.likeCount.text = "\(data.likeCount ?? 0)"
        self.titleLabel.text = data.name
        self.scoreLabel.text = "\(String(describing: data.refList?.first?.score ?? 0))"
        self.tagListView.textFont = UIFont.systemFont(ofSize: 12)
        
        if let tags = data.refList?.first?.tagList {
            for item in tags {
                self.tagListView.addTag(item.name ?? "none")
            }
        }
    }
    
    @objc private func stopPlayingMedia() {
        self.moviePlayer.pause()
    }
}
