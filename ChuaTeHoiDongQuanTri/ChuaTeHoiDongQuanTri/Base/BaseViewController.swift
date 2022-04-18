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
    
    lazy var textFieldView : UITextField = {
        let textfield = UITextField(frame: CGRect(x: 0, y: 0, width: ((self.navigationController?.navigationBar.frame.size.width)! * 2/3 ), height: 30))
        textfield.borderStyle = .none
        textfield.backgroundColor = .lightText
        textfield.placeholder = "  Searching"
        textfield.layer.cornerRadius = 10
        return textfield
    }()
    
    lazy var loadingView : UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.setUpBaseView()
    }
    
    func setUpBaseView() {
        view.addSubview(activityIndicatorView)
        activityIndicatorView.setDimensions(width: 50, height: 50)
        activityIndicatorView.center(inView: view)
        view.bringSubviewToFront(activityIndicatorView)
        activityIndicatorView.startAnimating()
    }
    
    func stopLoadingAnimate() {
        activityIndicatorView.stopAnimating()
    }

    func presentLockScreen() {
        view.addSubview(loadingView)
        view.bringSubviewToFront(loadingView)
        loadingView.addConstraintsToFillView(view)
        loadingView.addSubview(activityIndicatorView)
        activityIndicatorView.startAnimating()
        activityIndicatorView.setDimensions(width: 50, height: 50)
        activityIndicatorView.center(inView: loadingView)
        loadingView.isHidden = false
    }
    
    func unlockScreen() {
        stopLoadingAnimate()
        loadingView.removeFromSuperview()
    }
}
