//
//  
//  DailyNewsWebViewViewController.swift
//  ChuTeHoiDongQuanTri
//
//  Created by Valerian on 04/06/2022.
//
//

import UIKit
import WebKit

// MARK: - ViewProtocol
protocol DailyNewsWebViewViewProtocol: AnyObject {

}

// MARK: - DailyNewsWebView ViewController
class DailyNewsWebViewViewController: BaseViewController {
    var router: DailyNewsWebViewRouterProtocol!
    var viewModel: DailyNewsWebViewViewModelProtocol!
    var model: NewsModel?
    var webView: WKWebView!

    
    // MARK: - LifeCycle
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupInit()
        self.viewModel.onViewDidLoad()
    }
    
    // MARK: - Init
    private func setupInit() {
        let pathString = URLTypes.niteStreamArticle(self.model?.id).path
        let url = URL(string: pathString)!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
    }
    
    // MARK: - Action
    
}

extension DailyNewsWebViewViewController: WKNavigationDelegate {
    
}

// MARK: - DailyNewsWebView ViewProtocol
extension DailyNewsWebViewViewController: DailyNewsWebViewViewProtocol {

}
