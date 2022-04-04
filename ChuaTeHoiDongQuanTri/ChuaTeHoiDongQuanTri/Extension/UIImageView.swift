//
//  UIImageView.swift
//  ChuaTeHoiDongQuanTri
//
//  Created by Valerian on 30/03/2022.
//

import Foundation
import UIKit
import Kingfisher

extension UIImageView {
    public func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let maskPath = UIBezierPath(roundedRect: bounds,
                                    byRoundingCorners: corners,
                                    cornerRadii: CGSize(width: radius, height: radius))
        let shape = CAShapeLayer()
        shape.path = maskPath.cgPath
        layer.mask = shape
    }
}

extension UIImageView {
    func makeBlurImage(targetImageView:UIImageView?) {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = targetImageView!.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        // for supporting device rotation
        targetImageView?.addSubview(blurEffectView)
    }
    
    //set image
    func setImage(targetImageView : UIImageView ,with imageURL : String) {
        let url = URL(string: imageURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
        targetImageView.kf.setImage(with: url)
    }
    
    func setImageCaching(targetImageView : UIImageView ,with imageURL : String) {
        let url = URL(string: imageURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
        let processor = DownsamplingImageProcessor(size: targetImageView.bounds.size)

        targetImageView.kf.setImage(with: url, options: [
            .processor(processor),
            .loadDiskFileSynchronously,
            .cacheOriginalImage,
            .transition(.fade(0.2))
        ])
    }
    
    func setImageCachingv2(targetImageView : UIImageView ,with imageURL : String) {
        let url = URL(string: imageURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
        let processor = DownsamplingImageProcessor(size: targetImageView.bounds.size)
        
        targetImageView.kf.indicatorType = .activity
        targetImageView.kf.setImage(with: url, options: [
            .processor(processor),
            .scaleFactor(UIScreen.main.scale),
            .transition(.fade(1)),
            .cacheOriginalImage
        ])
    }
}
