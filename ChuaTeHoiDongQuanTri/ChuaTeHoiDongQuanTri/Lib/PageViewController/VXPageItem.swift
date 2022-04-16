//
//  PageItem.swift
//  1SK
//
//  Created by tuyenvx on 07/05/2021.
//

import Foundation
import UIKit

class VXPageItem {
    var viewController: UIViewController
    var pageBarItem: VXPageBarItem

    init(viewController: UIViewController, pageBarItem: VXPageBarItem) {
        self.viewController = viewController
        self.pageBarItem = pageBarItem
    }

    init(viewController: UIViewController, title: String) {
        let pageBarItem = VXPageBarItem(title: title)
        self.viewController = viewController
        self.pageBarItem = pageBarItem
    }
    
    init(viewController: UIViewController, icon: String) {
        let pageBarItem = VXPageBarItem(icon: icon)
        self.viewController = viewController
        self.pageBarItem = pageBarItem
    }
}
