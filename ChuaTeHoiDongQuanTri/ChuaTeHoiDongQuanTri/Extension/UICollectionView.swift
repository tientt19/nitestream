//
//  UICollectionView.swift
//  ChuaTeHoiDongQuanTri
//
//  Created by Valerian on 20/02/2022.
//

import Foundation
import UIKit

extension UICollectionView {
    public func registerCell<T: UICollectionViewCell>(nibName: T.Type) {
        register(UINib(nibName: nibName.className, bundle: nil), forCellWithReuseIdentifier: nibName.className)
    }
    
    public func registerCellForHeader<T: UICollectionReusableView>(nibName: T.Type) {
        register(UINib(nibName: nibName.className, bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: nibName.className)
    }
    
    public func registerCellForFooter<T: UICollectionReusableView>(nibName: T.Type) {
        register(UINib(nibName: nibName.className, bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: nibName.className)
    }
    
    public func dequeueHeader<T: UICollectionReusableView>(cellClass: T.Type, OfKind kind: String, forIndexPath indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: cellClass.className, for: indexPath) as? T else {
            fatalError(
                "Error: cell with id: \(cellClass.className) for indexPath: \(indexPath) is not \(T.self)")
        }
        return cell
    }
    
    public func dequeueFooter<T: UICollectionReusableView>(cellClass: T.Type, OfKind kind: String, forIndexPath indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: cellClass.className, for: indexPath) as? T else {
            fatalError(
                "Error: cell with id: \(cellClass.className) for indexPath: \(indexPath) is not \(T.self)")
        }
        return cell
    }
    
    public func dequeue<T: UICollectionViewCell>(cellClass: T.Type, forIndexPath indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(
            withReuseIdentifier: cellClass.className, for: indexPath) as? T else {
                fatalError(
                    "Error: cell with id: \(cellClass.className) for indexPath: \(indexPath) is not \(T.self)")
            }
        return cell
    }
}

class DynamicCollectionView: UICollectionView {
    override func layoutSubviews() {
        super.layoutSubviews()
        if !__CGSizeEqualToSize(bounds.size, self.intrinsicContentSize) {
            self.invalidateIntrinsicContentSize()
        }
    }
    
    override var intrinsicContentSize: CGSize {
        return contentSize
    }
}
