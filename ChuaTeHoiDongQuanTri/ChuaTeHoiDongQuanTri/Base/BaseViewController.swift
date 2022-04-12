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

    func presentLockScreen() {
        view.addSubview(loadingView)
        activityIndicatorView.startAnimating()
        loadingView.isHidden = false
        loadingView.addConstraintsToFillView(view)
    }
    
    func unlockScreen() {
        stopLoadingAnimate()
        loadingView.isHidden = true
    }
}
