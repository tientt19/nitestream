//
//  BaseViewController.swift
//  ChuaTeHoiDongQuanTri
//
//  Created by Valerian on 23/02/2022.
//

import UIKit
import FirebaseAuth

class BaseViewController: UIViewController {
    
    lazy var activityIndicatorView : UIActivityIndicatorView = {
        let loading = UIActivityIndicatorView()
        loading.hidesWhenStopped = true
        loading.color = UIColor.systemIndigo
        loading.style = .large
        return loading
    }()
    
    lazy var appIcon: UIView = {
        let view = UIView()
        view.backgroundColor = .lightText
        view.layer.cornerRadius = 15
        return view
    }()
    
    lazy var dailyNewslabel: UILabel = {
        let label = UILabel()
        label.text = "NiteStream News"
        label.font = UIFont(name: "Roboto-Bold", size: 18)
        label.textColor = .white
        return label
    }()
    
    lazy var searchView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: (self.navigationController?.navigationBar.frame.size.width)! , height: 30))
        view.backgroundColor = .clear
        return view
    }()
    
    lazy var coverTextFieldView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightText
        view.layer.cornerRadius = 15
        return view
    }()
    
    lazy var textFieldView : UITextField = {
        let textfield = UITextField()
        textfield.placeholder = "Searching"
        return textfield
    }()
    
    lazy var emptyView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
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
        setCustomSearchView()
        view.addSubview(activityIndicatorView)
        activityIndicatorView.setDimensions(width: 50, height: 50)
        activityIndicatorView.center(inView: view)
        view.bringSubviewToFront(activityIndicatorView)
        activityIndicatorView.startAnimating()
    }
    
    func stopLoadingAnimate() {
        activityIndicatorView.stopAnimating()
    }
    
    func setCustomSearchView() {
        self.searchView.addSubview(self.appIcon)
        self.searchView.addSubview(self.coverTextFieldView)
        self.coverTextFieldView.addSubview(self.textFieldView)
        
        self.appIcon.anchor(top: self.searchView.topAnchor, left: self.searchView.leftAnchor, bottom: self.searchView.bottomAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, width: 30, height: 30)
        
        self.coverTextFieldView.anchor(top: self.searchView.topAnchor, left: self.appIcon.rightAnchor, bottom: self.searchView.bottomAnchor, paddingTop: 0, paddingLeft: 10, paddingBottom: 0, width: (self.searchView.frame.width*2) / 3, height: 30)
        
        self.textFieldView.anchor(top: self.coverTextFieldView.topAnchor, left: self.coverTextFieldView.leftAnchor, bottom: self.coverTextFieldView.bottomAnchor, right: self.coverTextFieldView.rightAnchor, paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 5)
    }
    
    func createDailyNewNavBar() {
        self.searchView.addSubview(self.dailyNewslabel)
        self.dailyNewslabel.anchor(left: self.searchView.leadingAnchor, paddingLeft: 16)
        self.dailyNewslabel.centerX(inView: self.searchView)
    }
    
    func setAvatarImage(with userImage: URL) {
        let imageView = UIImageView()
        self.appIcon.addSubview(imageView)
        self.appIcon.clipsToBounds = true
        imageView.addConstraintsToFillView(self.appIcon)
        imageView.setImage(targetImageView: imageView, with: userImage)
    }
    
    func baseViewShowHud() {
        self.view.addSubview(loadingView)
        self.view.bringSubviewToFront(loadingView)
        self.loadingView.addConstraintsToFillView(view)
        self.loadingView.addSubview(activityIndicatorView)
        self.activityIndicatorView.startAnimating()
        self.activityIndicatorView.setDimensions(width: 50, height: 50)
        self.activityIndicatorView.center(inView: loadingView)
        self.loadingView.isHidden = false
    }

    func presentLockScreen() {
        self.view.addSubview(loadingView)
        self.view.bringSubviewToFront(loadingView)
        self.loadingView.addSubview(activityIndicatorView)
        self.activityIndicatorView.startAnimating()
        self.loadingView.isHidden = false
        self.loadingView.addConstraintsToFillView(view)
    }
    
    func unlockScreen() {
        self.stopLoadingAnimate()
        self.loadingView.isHidden = true
    }
    
    func baseViewHideHud() {
        self.stopLoadingAnimate()
        self.loadingView.removeFromSuperview()
    }
    
    func generateEmptyView() -> UIView? {
        let emptyLabel = UILabel()
        emptyLabel.text = "Không tìm thấy kết quả nào!!!"
        emptyLabel.textColor = UIColor.systemIndigo
        self.emptyView.addSubview(emptyLabel)
        emptyLabel.center(inView: self.emptyView)
        return self.emptyView
    }
}
