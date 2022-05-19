//
//  
//  SplashScreenViewController.swift
//  ChuTeHoiDongQuanTri
//
//  Created by Valerian on 18/05/2022.
//
//

import UIKit
import Lottie
import FirebaseAuth
import GoogleSignIn

// MARK: - ViewProtocol
protocol SplashScreenViewProtocol: AnyObject {
 
}

// MARK: - SplashScreen ViewController
class SplashScreenViewController: BaseViewController {
    var router: SplashScreenRouterProtocol!
    var viewModel: SplashScreenViewModelProtocol!
    
    @IBOutlet weak var splashView: AnimationView!
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupInit()
        self.viewModel.onViewDidLoad()
    }
    
    // MARK: - Init
    private func setupInit() {
        self.splashView.contentMode = .scaleAspectFit
        self.splashView.loopMode = .loop
        self.splashView.animationSpeed = 2
        self.splashView.play()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            self.onCheckAutoLogin()
        }
    }
    
    // MARK: - Action
    func onCheckAutoLogin() {
        if Auth.auth().currentUser != nil {
            self.router.goToHomeScreen()
        } else {
            self.router.goToLoginScreen()
        }
    }
}

// MARK: - SplashScreen ViewProtocol
extension SplashScreenViewController: SplashScreenViewProtocol {

}
