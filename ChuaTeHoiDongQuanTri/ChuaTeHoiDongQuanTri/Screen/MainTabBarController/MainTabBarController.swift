//
//  MainTabBarController.swift
//  ChuTeHoiDongQuanTri
//
//  Created by Valerian on 04/04/2022.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setInitAddItemTabBarController()
    }

    override var shouldAutorotate: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        let navigation = self.selectedViewController as? BaseNavigationViewController
        return navigation?.supportedInterfaceOrientations ?? .portrait
    }
    
    private func setInitAddItemTabBarController() {
        self.tabBar.layer.borderColor = UIColor(hex: "D4D4D4").cgColor
        self.tabBar.layer.borderWidth = 0.5
        
        UITabBar.appearance().shadowImage = UIImage()
        UITabBar.appearance().backgroundImage = UIImage()
        UITabBar.appearance().barTintColor = UIColor.white
        UITabBar.appearance().backgroundColor = .white
        UITabBar.appearance().tintColor = UIColor.systemIndigo
        UITabBar.appearance().unselectedItemTintColor = UIColor.black
        UITabBar.appearance().isTranslucent = false
        UITabBar.appearance().barStyle = .default
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)], for: .selected)
        
        let verticalSize: CGFloat = -1 // -3.0

        
        //HOME
        let homeController = HomePageViewRouter.createModule()
        
        homeController.tabBarItem.tag = 0
        homeController.tabBarItem.title  = "Trang chủ"
        homeController.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: verticalSize)
        homeController.tabBarItem.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        homeController.tabBarItem.image = UIImage(systemName: "house.fill")?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        homeController.tabBarItem.selectedImage = UIImage(named:        "house.fill")?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate).withTintColor(.systemIndigo)
        let homeNavController = BaseNavigationViewController(rootViewController: homeController)
        homeController.navigationItem.backBarButtonItem = UIBarButtonItem(title: String(), style: .plain, target: nil, action: nil)
        homeNavController.setHiddenNavigationBarViewControllers([])
        
        //MESSAGES
        let tiktokController = TikTokScreenRouter.createModule()
        
        tiktokController.tabBarItem.tag = 0
        tiktokController.tabBarItem.title  = "Wow"
        tiktokController.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: verticalSize)
        tiktokController.tabBarItem.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tiktokController.tabBarItem.image = UIImage(systemName: "infinity")?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        tiktokController.tabBarItem.selectedImage = UIImage(named: "infinity")?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate).withTintColor(.systemIndigo)
        let tiktokNavController = BaseNavigationViewController(rootViewController: tiktokController)
        tiktokNavController.setHiddenNavigationBarViewControllers([TikTokScreenViewController.self])
        
        //Discorver
        let discoveryController = DiscoveryScreenRouter.setupModule()

        discoveryController.tabBarItem.tag = 0
        discoveryController.tabBarItem.title  = "Discovery"
        discoveryController.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: verticalSize)
        discoveryController.tabBarItem.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        discoveryController.tabBarItem.image = UIImage(systemName: "beats.fit.pro")?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        discoveryController.tabBarItem.selectedImage = UIImage(named: "beats.fit.pro")?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate).withTintColor(.systemIndigo)
        let disCoveryNavController = BaseNavigationViewController(rootViewController: discoveryController)
        disCoveryNavController.setHiddenNavigationBarViewControllers([])
        
        //Profile
        //Discorver
        let profileViewcontroller = ProfileScreenRouter.setupModule()

        profileViewcontroller.tabBarItem.tag = 0
        profileViewcontroller.tabBarItem.title  = "Cá nhân"
        profileViewcontroller.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: verticalSize)
        profileViewcontroller.tabBarItem.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        profileViewcontroller.tabBarItem.image = UIImage(systemName: "tshirt")?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        profileViewcontroller.tabBarItem.selectedImage = UIImage(named: "tshirt")?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate).withTintColor(.systemIndigo)
        let profileNavController = BaseNavigationViewController(rootViewController: profileViewcontroller)
        profileNavController.setHiddenNavigationBarViewControllers([])
        
        // MARK:  Add Tabbar
        self.viewControllers = [
            homeNavController,
            tiktokController,
            discoveryController,
            profileViewcontroller
        ]
    }
}
