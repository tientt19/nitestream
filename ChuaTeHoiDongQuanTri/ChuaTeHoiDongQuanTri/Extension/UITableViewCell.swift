//
//  UITableViewCell.swift
//  ChuTeHoiDongQuanTri
//
//  Created by Valerian on 05/04/2022.
//

import Foundation
import UIKit

extension UITableViewCell {
    var tableView: UITableView? {
        return self.next(of: UITableView.self)
    }
    
    var indexPath: IndexPath? {
          return self.tableView?.indexPath(for: self)
    }
}
