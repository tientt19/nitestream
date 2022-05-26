//
//  CellCollectionStreaming.swift
//  ChuTeHoiDongQuanTri
//
//  Created by Valerian on 11/05/2022.
//

import UIKit
import StreamingTienPro

class CellCollectionStreaming: UICollectionViewCell {
    
    @IBOutlet weak var mediaPlayerView: UIView!
    @IBOutlet weak var view_controllMedia: UIView!
    @IBOutlet weak var img_controllMedia: UIView!
    
    var moviePlayer = MovieStreaming()

    override func awakeFromNib() {
        super.awakeFromNib()
        self.view_controllMedia.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(mediaTap)))
    }

    // TODO: Implement View Output Methods
    func playMedia(link: LinkMedia, and subLink: String) {
        self.moviePlayer.configure(in: self.mediaPlayerView)
        if let linkMedia = URL(string: link.mediaUrl) {
            self.moviePlayer.streaming(with: linkMedia, subRemote: subLink)
        }
    }
    
    @objc func mediaTap() {
        self.isHidden = true
        self.moviePlayer.play()
    }
    
    func stopPlayingMedia() {
        self.moviePlayer.pause()
    }
}
