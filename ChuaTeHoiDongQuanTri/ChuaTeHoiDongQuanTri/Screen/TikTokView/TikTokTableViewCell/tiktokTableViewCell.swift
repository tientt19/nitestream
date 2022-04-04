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
}
