//
//  UITableView.swift
//  AppWidgetsTest
//
//  Created by Valerian on 30/11/2021.
//

import Foundation
import UIKit

extension NSObject {
    class var className: String {
        return String(describing: self)
    }
}

extension UITableViewCell {
    static var reuseIdentifier: String {
        return NSStringFromClass(self)
    }
}

extension UITableView {
    
    public func registerCell<T: UITableViewCell>(nibName: T.Type) {
        register(UINib(nibName: nibName.className , bundle: nil), forCellReuseIdentifier: nibName.className)
    }
        
    public func dequeue<T: UITableViewCell>(cellClass: T.Type) -> T? {
        return dequeueReusableCell(withIdentifier: cellClass.className) as? T
    }
    
    public func dequeue<T: UITableViewCell>(cellClass: T.Type, forIndexPath indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(
            withIdentifier: cellClass.className, for: indexPath) as? T else {
                fatalError(
                    "Error: cell with id: \(cellClass.className) for indexPath: \(indexPath) is not \(T.self)")
            }
        return cell
    }
}

extension Formatter {
    static let withSeparator: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = "."
        return formatter
    }()
}

extension Numeric {
    var formattedWithSeparator: String { Formatter.withSeparator.string(for: self) ?? "" }
}


