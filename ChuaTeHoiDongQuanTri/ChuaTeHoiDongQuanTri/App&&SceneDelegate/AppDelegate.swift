//
//  AppDelegate.swift
//  ChuaTeHoiDongQuanTri
//
//  Created by Valerian on 19/02/2022.
//

import UIKit
import FirebaseCore
import FirebaseAuth
import GoogleSignIn

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.setInitFirebase()
        self.setInitRootViewController()
        return true
    }
    // MARK: - Firebase
    func setInitFirebase() {
        FirebaseApp.configure()
    }
    
    @available(iOS 9.0, *)
    func application(_ application: UIApplication, open url: URL,
                     options: [UIApplication.OpenURLOptionsKey: Any])
      -> Bool {
      return GIDSignIn.sharedInstance.handle(url)
    }
    
    // MARK: ViewController
    func setInitRootViewController() {
        let iOSVersion = ProcessInfo().operatingSystemVersion.majorVersion
        if iOSVersion < 13 { // iOS version < 13.0.0
            // Facebook
            let frame = UIScreen.main.bounds
            let windowSize = CGSize(width: min(frame.width, frame.height), height: max(frame.width, frame.height))
            window = UIWindow(frame: CGRect(origin: .zero, size: windowSize))
            window?.overrideUserInterfaceStyle = .light
            let rootController = SplashScreenRouter.setupModule()
            window?.rootViewController = rootController
            window?.makeKeyAndVisible()
        }
    }
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return .portrait
    }
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
}

