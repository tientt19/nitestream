//
//  BaseViewController.swift
//  ChuaTeHoiDongQuanTri
//
//  Created by Valerian on 23/02/2022.
//

import UIKit

class BaseViewController: UIViewController {
    
    lazy var activityIndicatorView : UIActivityIndicatorView = {
        let loading = UIActivityIndicatorView()
        loading.hidesWhenStopped = true
        loading.style = .large
        return loading
    }()
    
    lazy var loadingView : UIView = {
        let view = UIView()
        return view
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func setUpBaseView() {
        view.addSubview(activityIndicatorView)
        activityIndicatorView.setDimensions(width: 50, height: 50)
        activityIndicatorView.center(inView: view)
        activityIndicatorView.startAnimating()
    }
    
    func stopLoadingAnimate() {
        activityIndicatorView.stopAnimating()
    }
    
}
