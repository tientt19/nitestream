//
//  CellSeachingCollectionView.swift
//  ChuTeHoiDongQuanTri
//
//  Created by Valerian on 06/05/2022.
//

import UIKit

class CellSeachingCollectionView: UICollectionViewCell {
    
    @IBOutlet weak var label: UILabel!
    
    static func cellSize(width: CGFloat, text: String) -> CGSize {
        return TextSize.size(text, font: UIFont.systemFont(ofSize: 16), width: width).size
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    func update(with dataString: String) {
        self.label.text = dataString
    }
}
