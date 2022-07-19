//
//  BaseViewController.swift
//  ChuaTeHoiDongQuanTri
//
//  Created by Valerian on 23/02/2022.
//

import UIKit
import SnapKit
import FirebaseAuth

class BaseViewController: UIViewController {
    
    var viewError: ErrorView?
    private var progressHub: UIActivityIndicatorView?
    private var viewProgressHub: UIView?
    private var viewNoInternetConnection = UIView()
    private var constraint_height_ViewNoInternetConnection: Constraint?
    var gIsHaveInternetConnected = true
    
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
    
    lazy var searchView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: (self.navigationController?.navigationBar.frame.size.width)! , height: 30))
        view.backgroundColor = .clear
        return view
    }()
    
    lazy var messageButton : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "message.and.waveform.fill"), for: .normal)
        button.addTarget(self, action: #selector(goToChat), for: .touchUpInside)
        button.tintColor = .white
        return button
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
        // checking internet
        self.viewNoInternetConnection = self.createNoInternetConnectionView()
        self.setObserverInternetConnection()
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
        self.searchView.addSubview(self.messageButton)
        self.coverTextFieldView.addSubview(self.textFieldView)
        
        self.appIcon.anchor(top: self.searchView.topAnchor, left: self.searchView.leftAnchor, bottom: self.searchView.bottomAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, width: 30, height: 30)
        
        self.messageButton.anchor(top: self.searchView.topAnchor, left: self.coverTextFieldView.rightAnchor, bottom: self.searchView.bottomAnchor, paddingTop: 0, paddingLeft: 16, paddingBottom: 0, width: 30, height: 30)
        
        self.coverTextFieldView.anchor(top: self.searchView.topAnchor, left: self.appIcon.rightAnchor, bottom: self.searchView.bottomAnchor, paddingTop: 0, paddingLeft: 10, paddingBottom: 0, width: (self.searchView.frame.width*2) / 3, height: 30)
        
        self.textFieldView.anchor(top: self.coverTextFieldView.topAnchor, left: self.coverTextFieldView.leftAnchor, bottom: self.coverTextFieldView.bottomAnchor, right: self.coverTextFieldView.rightAnchor, paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 5)
    }
    
    @objc func goToChat() {
        let viewController = ChattingRouter.setupModule()
        viewController.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(viewController, animated: true)
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

// MARK: - Internet Connection
extension BaseViewController {
    @discardableResult private func createNoInternetConnectionView() -> UIView {
        let noInternetView = UIView()
        noInternetView.alpha = 0
        noInternetView.backgroundColor = .white
        self.view.addSubview(noInternetView)
        noInternetView.snp.makeConstraints { (make) in
            make.bottom.leading.trailing.equalTo(self.view.safeAreaLayoutGuide)
            self.constraint_height_ViewNoInternetConnection = make.height.equalTo(0).constraint
        }
        let wifiImageView = UIImageView(image: UIImage(named: "ic_wifi"))
        noInternetView.addSubview(wifiImageView)
        wifiImageView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(17)
            make.leading.equalToSuperview().offset(16)
        }
        let contentLabel = createNoInternetViewContentLabel()
        noInternetView.addSubview(contentLabel)
        contentLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(12)
            make.leading.equalTo(wifiImageView.snp.trailing).offset(18)
            make.trailing.equalToSuperview().offset(-16)
        }
        let closeButton = createNoInternetViewCloseButton()
        noInternetView.addSubview(closeButton)
        closeButton.snp.makeConstraints { (make) in
            make.top.equalTo(contentLabel.snp.bottom).offset(12)
            make.leading.equalTo(wifiImageView.snp.leading)
            make.height.equalTo(35)
        }
        let retryButton = createNoInternetViewRetryButton()
        noInternetView.addSubview(retryButton)
        retryButton.snp.makeConstraints { (make) in
            make.centerY.height.width.equalTo(closeButton)
            make.leading.equalTo(closeButton.snp.trailing).offset(27)
            make.trailing.equalTo(contentLabel)
        }
        return noInternetView
    }

    private func createNoInternetViewContentLabel() -> UILabel {
        
        ///////////////////////////////
        
        let contentLabel = UILabel()
        contentLabel.text = "Không có kết nối mạng.\nVui lòng kiểm tra kết nối mạng của bạn."
        contentLabel.font = UIFont.systemFont(ofSize: 14)
        contentLabel.textColor = UIColor.darkText
        contentLabel.numberOfLines = 0
        contentLabel.lineBreakMode = .byWordWrapping
        return contentLabel
    }

    private func createNoInternetViewCloseButton() -> UIButton {
        let closeButton = UIButton()
        closeButton.setTitle("Đóng", for: .normal)
        closeButton.setTitleColor(.white, for: .normal)
        closeButton.backgroundColor = .systemIndigo
        closeButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        closeButton.addTarget(self, action: #selector(self.buttonCloseNoInternetConnectionViewDidTapped), for: .touchUpInside)
        closeButton.cornerRadius = 4
        return closeButton
    }

    private func createNoInternetViewRetryButton() -> UIButton {
        let retryButton = UIButton()
        retryButton.setTitle("Thử lại", for: .normal)
        retryButton.setTitleColor(.white, for: .normal)
        retryButton.backgroundColor = .systemIndigo
        retryButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        retryButton.addTarget(self, action: #selector(self.buttonRetryInternetConnectionDidTapped), for: .touchUpInside)
        retryButton.cornerRadius = 4
        return retryButton
    }

    private func setObserverInternetConnection() {
        print("BaseViewController setObserverInternetConnection")
        NotificationCenter.default.addObserver(self, selector: #selector(self.onInternetConnectionAvailable), name: .connectionAvailable, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.onInternetConnectionUnavailable), name: .connectionUnavailable, object: nil)
    }

    @objc func onInternetConnectionAvailable() {
        print("BaseViewController onInternetConnectionAvailable")
        gIsHaveInternetConnected = true
        self.hideNoInternetConnectionView()
    }

    @objc func onInternetConnectionUnavailable() {
        print("BaseViewController onInternetConnectionUnavailable")
        gIsHaveInternetConnected = false
        guard self.viewError == nil, !self.isKind(of: LoginScreenViewController.self), !self.isKind(of: HomePageViewViewController.self) else {
            return
        }
        self.showNoInternetConnectionView()
    }

    @objc func buttonCloseNoInternetConnectionViewDidTapped() {
        self.hideNoInternetConnectionView()
    }

    @objc func buttonRetryInternetConnectionDidTapped() {
        if InternetConnection.shared.isAvailable() {
            self.hideNoInternetConnectionView()
        }
    }

    private func showNoInternetConnectionView() {
        self.showAlert(title: "Lỗi kết nối", message: "Không có kết nối mạng.\nVui lòng kiểm tra kết nối mạng của bạn.")
//        self.viewNoInternetConnection.alpha = 1
//        self.view.bringSubviewToFront(self.viewNoInternetConnection)
//        self.constraint_height_ViewNoInternetConnection?.update(offset: 107)
//        UIView.animate(withDuration: Contants.Number.animationTime) {
//            self.view.layoutIfNeeded()
//        }
    }

    private func hideNoInternetConnectionView() {
        self.constraint_height_ViewNoInternetConnection?.update(offset: 0)
        UIView.animate(withDuration: Constant.Number.animationTime, animations: {
            self.view.layoutIfNeeded()
        }, completion: { _ in
            self.viewNoInternetConnection.alpha = 0
        })
    }
}


protocol ErrorViewDelegate: AnyObject {
    func onRetryButtonDidTapped(_ errorView: UIView)
}


class ErrorView: UIView {

    private var errorMessage: String = ""
    weak var delegate: ErrorViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupDefatults()
    }

    convenience init(message: String) {
        self.init(frame: .zero)
        errorMessage = message
        setupDefatults()
    }

    private func setupDefatults() {
        backgroundColor = .white
        let view = UIView()
        addSubview(view)
        view.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.leading.equalToSuperview().offset(51)
        }
        let imageView = UIImageView(image: UIImage(named: "error"))
        view.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.top.centerX.equalToSuperview()
            make.width.equalTo(147)
            make.height.equalTo(98)
        }
        // Title Label
        let titleLabel = createTitleLabel()

        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(imageView.snp.bottom).offset(33)
            make.centerX.equalToSuperview()
        }
        // Content Label
        let contentLabel = createContentLabel()
        view.addSubview(contentLabel)

        contentLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(12)
            make.leading.centerX.equalToSuperview()
            make.height.greaterThanOrEqualTo(0)
        }

        let retryButton = createRetryButton()
        view.addSubview(retryButton)

        retryButton.snp.makeConstraints { (make) in
            make.top.equalTo(contentLabel.snp.bottom).offset(19)
            make.centerX.bottom.equalToSuperview()
            make.width.equalTo(146)
            make.height.equalTo(36)
        }
    }

    private func createTitleLabel() -> UILabel {
        let titleLabel = UILabel()
        titleLabel.text = "Đã có lỗi xảy ra"
        titleLabel.font = UIFont.systemFont(ofSize: 16)
        titleLabel.textColor = .darkText
        titleLabel.textAlignment = .center
        return titleLabel
    }

    private func createContentLabel() -> UILabel {
        let contentLabel = UILabel()
        contentLabel.font = UIFont.systemFont(ofSize: 14)
        contentLabel.textColor = .lightText
        contentLabel.textAlignment = .center
        contentLabel.text = errorMessage
        return contentLabel
    }

    private func createRetryButton() -> UIButton {
        let retryButton = UIButton()
        retryButton.backgroundColor = .systemIndigo
        retryButton.setTitle("Thử lại", for: .normal)
        retryButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        retryButton.cornerRadius = 18
        retryButton.setTitleColor(.white, for: .normal)
        retryButton.addTarget(self, action: #selector(buttonRetryDidTapped), for: .touchUpInside)
        return retryButton
    }

    @objc func buttonRetryDidTapped() {
        delegate?.onRetryButtonDidTapped(self)
    }
}

extension BaseViewController {
    
    func showProgressHud(offsetTop: CGFloat = 0, offsetBottom: CGFloat = 0, position: ProgressPosition = .full, backgroundColor: UIColor = .clear) {
        self.viewProgressHub?.backgroundColor = backgroundColor
        self.view.bringSubviewToFront(self.viewProgressHub!)
        let navigationBarHeight = navigationController?.navigationBar.height ?? 0
        let tabbarHeight = tabBarController?.tabBar.height ?? 0
        var statusBarHeight = UIApplication.shared.statusBarFrame.height
        if #available(iOS 13, *) {
            statusBarHeight = UIApplication.shared.keyWindow?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        }
        var topMargin: CGFloat = 0
        var bottomMargin: CGFloat = 0
        switch position {
        case .full:
            topMargin = offsetTop
            bottomMargin = offsetBottom
        case .underStatusBar:
            topMargin = statusBarHeight + offsetTop
            bottomMargin = offsetBottom
        case .aboveTabbar:
            topMargin = offsetTop
            bottomMargin = tabbarHeight + offsetBottom
        case .underNavigationBar:
            topMargin = statusBarHeight + navigationBarHeight + offsetTop
            bottomMargin = offsetBottom
        case .aboveTabbarAndUnderNavigationBar:
            topMargin = statusBarHeight + navigationBarHeight + offsetTop
            bottomMargin = offsetBottom + tabbarHeight
        case .aboveTabbarAndUnderStatusBar:
            topMargin = statusBarHeight + offsetTop
            bottomMargin = offsetBottom + tabbarHeight
        }

        self.viewProgressHub?.snp.remakeConstraints { (make) in
            make.top.equalToSuperview().offset(topMargin)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().offset(-bottomMargin)
        }
        self.progressHub?.startAnimating()
        self.viewProgressHub?.isHidden = false
            self.viewProgressHub?.alpha = 1
            self.view.layoutIfNeeded()
    }

    func hideProgressHud() {
        self.progressHub?.stopAnimating()
        UIView.animate(withDuration: Constant.Number.animationTime, animations: {
            self.viewProgressHub?.alpha = 0
        }, completion: { _ in
            self.viewProgressHub?.isHidden = true
        })
    }
    
    func showAlert(title:String, message:String) {
        let alert = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Close App",
                                      style: UIAlertAction.Style.destructive,
                                      handler: {(_: UIAlertAction!) in
                let _ = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
                    exit(0)
                }
        }))
        
        DispatchQueue.main.async { [weak self] in
            self?.present(alert, animated: true, completion: nil)
        }
    }
}
