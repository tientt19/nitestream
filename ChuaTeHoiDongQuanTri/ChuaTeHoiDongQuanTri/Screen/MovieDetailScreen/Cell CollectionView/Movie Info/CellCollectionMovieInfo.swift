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
        self.movieScore.text = "Scored : \(String(describing: data.score)) |  Year : \(String(describing: data.year))"
        self.introduction.text = data.introduction
    }
}
