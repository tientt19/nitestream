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
import FBSDKCoreKit
import FacebookCore
import FBSDKLoginKit
import FacebookLogin

// MARK: - Interactor Input Protocol
protocol LoginScreenInteractorInputProtocol {
    func handleLoginWithGoogle(with vc: UIViewController)
    func handleLoginwithFacebook(viewController: UIViewController)
}

// MARK: - Interactor Output Protocol
protocol LoginScreenInteractorOutputProtocol: AnyObject {
    func didSigninByGoogle()
    func didSigninByFacebook()
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
    
    func handleLoginwithFacebook(viewController: UIViewController) {
        let loginManager = LoginManager()
        loginManager.logIn(permissions: ["public_profile", "email"], from: viewController) { [weak self] (result, _) in
            
            guard let token = result?.token?.tokenString else {
                dLogDebug("<Login> Facebook error ")
                return
            }
            
            dLogDebug("<Login> Facebook success token: \(token)")
            
            self?.output?.didSigninByFacebook()

//            let credential = FacebookAuthProvider.credential(withAccessToken: token)
//
//            Auth.auth().signIn(with: credential) { authResult, error in
//                if let error = error {
//                    dLogDebug(error.localizedDescription)
//                } else {
//                }
//            }
        }
    }
}

extension LoginScreenInteractorInput {
    // Adapted from https://auth0.com/docs/api-auth/tutorials/nonce#generate-a-cryptographically-random-nonce
    private func randomNonceString(length: Int = 32) -> String {
        precondition(length > 0)
        let charset: [Character] =
        Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
        var result = ""
        var remainingLength = length
        
        while remainingLength > 0 {
            let randoms: [UInt8] = (0 ..< 16).map { _ in
                var random: UInt8 = 0
                let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
                if errorCode != errSecSuccess {
                    fatalError(
                        "Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)"
                    )
                }
                return random
            }
            
            randoms.forEach { random in
                if remainingLength == 0 {
                    return
                }
                
                if random < charset.count {
                    result.append(charset[Int(random)])
                    remainingLength -= 1
                }
            }
        }
        return result
    }
}
