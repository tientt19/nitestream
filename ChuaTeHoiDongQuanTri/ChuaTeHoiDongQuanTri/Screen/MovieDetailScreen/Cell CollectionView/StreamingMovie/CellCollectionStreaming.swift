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
    
    var moviePlayer = MovieStreaming()

    override func awakeFromNib() {
        super.awakeFromNib()
        NotificationCenter.default.addObserver(self, selector: #selector(stopPlayingMedia), name: .stopPlayingMedia, object: nil)
    }

    // TODO: Implement View Output Methods
    func playMedia(link: LinkMedia, and subLink: String) {
        self.moviePlayer.configure(in: self.mediaPlayerView)
        if let linkMedia = URL(string: link.mediaUrl) {
            self.moviePlayer.streaming(with: linkMedia, subRemote: subLink)
        }
    }
    
    @objc func stopPlayingMedia() {
        self.moviePlayer.pause()
    }
}
