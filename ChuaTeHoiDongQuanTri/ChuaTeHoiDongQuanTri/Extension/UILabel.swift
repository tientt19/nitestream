//
//  UILabel.swift
//  ChuTeHoiDongQuanTri
//
//  Created by Valerian on 14/04/2022.
//

import Foundation
import UIKit

extension UILabel {
    func textWidth() -> CGFloat {
        return UILabel.textWidth(label: self)
    }
    
    class func textWidth(label: UILabel) -> CGFloat {
        return textWidth(label: label, text: label.text!)
    }
    
    class func textWidth(label: UILabel, text: String) -> CGFloat {
        return textWidth(font: label.font, text: text)
    }
    
    class func textWidth(font: UIFont, text: String) -> CGFloat {
        let myText = text as NSString
        
        let rect = CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)
        let labelSize = myText.boundingRect(with: rect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return ceil(labelSize.width)
    }
    
    func countLines() -> Int {
       guard let myText = self.text as NSString? else {
         return 0
       }
       // Call self.layoutIfNeeded() if your view uses auto layout
       let rect = CGSize(width: self.bounds.width, height: CGFloat.greatestFiniteMagnitude)
       let labelSize = myText.boundingRect(with: rect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: self.font as Any], context: nil)
       return Int(ceil(CGFloat(labelSize.height) / self.font.lineHeight))
     }
}
