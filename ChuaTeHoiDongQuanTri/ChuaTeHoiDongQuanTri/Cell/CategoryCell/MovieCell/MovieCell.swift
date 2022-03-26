//
//  MovieCell.swift
//  ChuaTeHoiDongQuanTri
//
//  Created by Valerian on 25/03/2022.
//

import UIKit

class MovieCell: UICollectionViewCell {
    
    @IBOutlet weak var posterImage : UIImageView!
    @IBOutlet weak var titleLabel : UILabel!
    @IBOutlet weak var blurImageView : UIImageView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        blurImageView.makeBlurImage(targetImageView: blurImageView)
    }

    func configure(_ imageURL: String,_ title: String) {
        posterImage.setImage(targetImageView: posterImage, with: imageURL)
        blurImageView.setImage(targetImageView: blurImageView, with: imageURL)
        titleLabel.text = title
    }
    
    func imageDimenssions(url: String) -> String{
        if let imageSource = CGImageSourceCreateWithURL(URL(string: url)! as CFURL, nil) {
            if let imageProperties = CGImageSourceCopyPropertiesAtIndex(imageSource, 0, nil) as Dictionary? {
                let pixelWidth = imageProperties[kCGImagePropertyPixelWidth] as! Int
                let pixelHeight = imageProperties[kCGImagePropertyPixelHeight] as! Int
                return "Width: \(pixelWidth), Height: \(pixelHeight)"
            }
        }
        return "None"
    }
}
