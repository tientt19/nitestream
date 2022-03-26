//
//  BaseNavigationViewController.swift
//  ChuaTeHoiDongQuanTri
//
//  Created by Valerian on 25/03/2022.
//

import UIKit

class BaseNavigationViewController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    open override func viewWillLayoutSubviews() {
        navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
}
