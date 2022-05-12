//
//  MovieInfo.swift
//  ChuTeHoiDongQuanTri
//
//  Created by Valerian on 11/05/2022.
//

import UIKit

class CellCollectionMovieInfo: UICollectionViewCell {
    
    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var movieScore: UILabel!
    @IBOutlet weak var introduction: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(data: MovieInfo) {
        if let score = data.score, let year = data.score {
            self.movieName.text = data.name
            self.movieScore.text = "Scored : \(String(describing: score)) |  Year : \(String(describing: year))"
            self.introduction.text = data.introduction
            dLogDebug(self.introduction.countLines())
        } else {
            self.movieScore.text = ""
        }
    }
    
    func hideIntroduction() {
        self.introduction.isHidden = true
    }
    
    func hideInfo() {
        self.movieName.isHidden = true
        self.movieScore.isHidden = true
        self.introduction.isHidden = false
    }
}
