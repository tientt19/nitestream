//
//  tiktokTableViewCell.swift
//  ChuTeHoiDongQuanTri
//
//  Created by Valerian on 04/04/2022.
//

import UIKit
import AVFoundation
import StreamingTienPro

protocol openDetailMovieProtocol : AnyObject {
    func getMovieDetail(index : Int)
}

class tiktokTableViewCell: UITableViewCell, ASAutoPlayVideoLayerContainer {
    
    @IBOutlet weak var mediaPlayerView : UIView!
    @IBOutlet weak var posterImamge : UIImageView!
    @IBOutlet weak var titleLabel : UILabel!
    @IBOutlet weak var scoreLabel : UILabel!
    @IBOutlet weak var likeCount : UILabel!
    @IBOutlet weak var tagListView : TagListView!
    @IBOutlet weak var tiktokInfo : UIView!
    
    var delegate : openDetailMovieProtocol?
    var playerController: ASVideoPlayerController?
    var videoLayer: AVPlayerLayer = AVPlayerLayer()
    var videoURL: String? {
        didSet {
            if let videoURL = videoURL {
                ASVideoPlayerController.sharedVideoPlayer.setupVideoFor(url: videoURL)
            }
            videoLayer.isHidden = videoURL == nil
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        tiktokInfo.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(openDetail)))
        mediaPlayerView.clipsToBounds = true
        videoLayer.backgroundColor = UIColor.clear.cgColor
        videoLayer.videoGravity = AVLayerVideoGravity.resize
        mediaPlayerView.layer.addSublayer(videoLayer)
        selectionStyle = .none
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        videoLayer.frame = mediaPlayerView.bounds
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    @objc func openDetail() {
        delegate?.getMovieDetail(index: self.indexPath!.row)
    }
    
    func configure(link: String, data : ReviewMedia) {
        self.videoURL = link
        posterImamge.setImageCachingv2(targetImageView: posterImamge, with: data.refList.first?.coverVerticalUrl ?? "")
        likeCount.text = "\(data.likeCount ?? 0)"
        titleLabel.text = data.name
        scoreLabel.text = "\(String(describing: data.refList.first?.score ?? 0))"
        tagListView.textFont = UIFont.systemFont(ofSize: 12)
        tagListView.addTags(data.refList.first?.tagList.map { $0.name } ?? [""])
    }
    
    func visibleVideoHeight() -> CGFloat {
        let videoFrameInParentSuperView: CGRect? = self.superview?.superview?.convert(mediaPlayerView.frame, from: mediaPlayerView)
        guard let videoFrame = videoFrameInParentSuperView,
            let superViewFrame = superview?.frame else {
             return 0
        }
        let visibleVideoFrame = videoFrame.intersection(superViewFrame)
        return visibleVideoFrame.size.height
    }
}
