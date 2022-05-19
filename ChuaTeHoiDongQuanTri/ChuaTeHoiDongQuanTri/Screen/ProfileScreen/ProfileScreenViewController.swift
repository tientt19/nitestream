//
//  
//  ProfileScreenViewController.swift
//  ChuTeHoiDongQuanTri
//
//  Created by Valerian on 19/05/2022.
//
//

import UIKit
import FirebaseAuth

// MARK: - ViewProtocol
protocol ProfileScreenViewProtocol: AnyObject {

}

// MARK: - ProfileScreen ViewController
class ProfileScreenViewController: BaseViewController {
    var router: ProfileScreenRouterProtocol!
    var viewModel: ProfileScreenViewModelProtocol!
    
    
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupInit()
        self.viewModel.onViewDidLoad()
    }
    
    // MARK: - Init
    private func setupInit() {

    }
    
    // MARK: - Action
    @IBAction func signOut(_ sender: Any) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            self.router.goToLoginScreen()
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
}

// MARK: - ProfileScreen ViewProtocol
extension ProfileScreenViewController: ProfileScreenViewProtocol {
    
}
