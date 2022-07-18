//
//  CellCollectionViewAdvancedSearch.swift
//  nitestream
//
//  Created by Valerian on 13/06/2022.
//

import UIKit

class CellCollectionViewAdvancedSearch: UICollectionViewCell {
    
    @IBOutlet weak var posterImageView: UIImageView!
    
    var model: SearchResults? {
        didSet {
            self.posterImageView.setImageCachingv2(targetImageView: self.posterImageView, with: model?.coverVerticalUrl ?? "")
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
