//
//  SearchingViewController.swift
//  ChuaTeHoiDongQuanTri
//
//  Created by Valerian on 28/03/2022.
//

import UIKit

class SearchingViewController: UIViewController {
    
   
    
    var presenter : SearchingPresenterProtocols?

    override func viewDidLoad() {
        super.viewDidLoad()
        setUPView()
    }
}

extension SearchingViewController {
    func setUPView() {
        
    }
}

extension SearchingViewController : SearchingViewProtocols {

}
