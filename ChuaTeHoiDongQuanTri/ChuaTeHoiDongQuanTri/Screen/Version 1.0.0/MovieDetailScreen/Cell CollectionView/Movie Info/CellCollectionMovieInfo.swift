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
        self.movieName.text = data.name
        self.introduction.text = data.introduction
        if let score = data.score {
            self.movieScore.text = "Scored : \(String(describing: score)) |  Year : \(String(describing: data.year!))"
        } else {
            self.movieScore.text = "Year : \(String(describing: data.year!))"
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
