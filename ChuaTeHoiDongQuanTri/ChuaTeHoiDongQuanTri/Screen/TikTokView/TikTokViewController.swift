//
//  TikTokViewController.swift
//  ChuaTeHoiDongQuanTri
//
//  Created by Valerian on 25/03/2022.
//

import UIKit

class TikTokViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        APIService.shared.getTikTokMedia()
        
    }

}
