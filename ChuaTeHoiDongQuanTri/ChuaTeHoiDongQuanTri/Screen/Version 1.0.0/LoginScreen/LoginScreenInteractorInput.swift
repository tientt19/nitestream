//
//  
//  LoginScreenInteractorInput.swift
//  ChuTeHoiDongQuanTri
//
//  Created by Valerian on 19/05/2022.
//
//

import UIKit
import FirebaseCore
import FirebaseAuth
import GoogleSignIn

// MARK: - Interactor Input Protocol
protocol LoginScreenInteractorInputProtocol {
    func handleLoginWithGoogle(with vc: UIViewController)
}

// MARK: - Interactor Output Protocol
protocol LoginScreenInteractorOutputProtocol: AnyObject {
    func didSigninByGoogle()
}

// MARK: - LoginScreen InteractorInput
class LoginScreenInteractorInput {
    weak var output: LoginScreenInteractorOutputProtocol?
}

// MARK: - LoginScreen InteractorInputProtocol
extension LoginScreenInteractorInput: LoginScreenInteractorInputProtocol {
    func handleLoginWithGoogle(with vc: UIViewController) {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        
        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)
        
        // Start the sign in flow!
        GIDSignIn.sharedInstance.signIn(with: config, presenting: vc) { [unowned self] user, error in
            
            if error != nil { return }
            
            guard
                let authentication = user?.authentication,
                let idToken = authentication.idToken
            else {
                return
            }
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                           accessToken: authentication.accessToken)
            Auth.auth().signIn(with: credential) { [unowned self] (_, error) in
                if let error = error {
                    dLogDebug(error.localizedDescription)
                } else {
                    // change state sign in
                    // go to home screen
                    self.output?.didSigninByGoogle()
                }
            }
        }
    }
}
