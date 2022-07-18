//
//  SHCircleBarController.swift
//  SHCircleBar
//
//  Created by Adrian Perțe on 19/02/2019.
//  Copyright © 2019 softhaus. All rights reserved.
//

import UIKit

class SHCircleBarController: UITabBarController {

    private var circleView : UIView!
    private var circleImageView: UIImageView!
    
    public override var selectedViewController: UIViewController? {
        willSet {
            guard let newValue = newValue,
                  let tabBar = tabBar as? SHCircleBar,
                  let index = viewControllers?.firstIndex(of: newValue)
                  else { return }
            updateCircle(index: index)
            tabBar.select(itemAt: index, animated: true)
        }
    }
    
    public override var selectedIndex: Int {
        willSet {
            guard let tabBar = tabBar as? SHCircleBar else { return }
            updateCircle(index: newValue)
            tabBar.select(itemAt: newValue, animated: true)
        }
    }
    
    private var _barHeight: CGFloat = 74
    public var barHeight: CGFloat {
        get {
            if #available(iOS 11.0, *) {
                return _barHeight + view.safeAreaInsets.bottom
            } else { return _barHeight }
        }
        set {
            _barHeight = newValue
            updateTabBarFrame()
        }
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        let tabBar = SHCircleBar()
        self.setValue(tabBar, forKey: "tabBar")
        self.setInitAddItemTabBarController()
        addCirleView()
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        circleImageView.image = self.tabBar.selectedItem?.image ?? self.tabBar.items?.first?.image
    }
    
    open override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        updateTabBarFrame()
    }
    
    open override func viewSafeAreaInsetsDidChange() {
        if #available(iOS 11.0, *) {
            super.viewSafeAreaInsetsDidChange()
        }
        updateTabBarFrame()
    }
    
    open override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        guard let index = tabBar.items?.firstIndex(of: item) else { return }
        updateCircle(index: index)
    }
    
}

extension SHCircleBarController {
    public func updateCircle(index: Int) {
        guard let items = tabBar.items,
              let vcs = viewControllers,
              index < items.count,
              index < vcs.count,
              index != selectedIndex else { return }
        
        let item = items[index]
        let controller = vcs[index]
            
        let tabWidth = self.view.bounds.width / CGFloat(items.count)
        let circleWidth = self.circleView.bounds.width
        
        UIView.animate(withDuration: 0.3) { [weak self] in
            guard let `self` = self else { return }
            self.circleView.frame = CGRect(
                x: (tabWidth * CGFloat(index) + tabWidth / 2 - circleWidth*0.5),
                y: self.circleView.frame.minY,
                width: circleWidth,
                height: circleWidth)
        }
        
        UIView.animate(withDuration: 0.15) { [weak self] in
            self?.circleImageView.alpha = 0
        } completion: { [weak self] (_) in
            self?.circleImageView.image = item.image
            UIView.animate(withDuration: 0.15, animations: { [weak self] in
                self?.circleImageView.alpha = 1
            })
        }
        delegate?.tabBarController?(self, didSelect: controller)
    }
    
    fileprivate func updateTabBarFrame() {
        var tabFrame = self.tabBar.frame
        tabFrame.size.height = barHeight
        tabFrame.origin.y = self.view.frame.size.height - barHeight
        self.tabBar.frame = tabFrame
        tabBar.setNeedsLayout()
    }
    
    fileprivate func addCirleView() {
        let tabWidth = self.view.bounds.width / CGFloat(self.tabBar.items?.count ?? 4)
        let circleViewWidth = tabWidth*0.5
        let circleViewRadius = circleViewWidth*0.5
        
        self.circleView = UIView(frame: .zero)
        circleView.layer.cornerRadius = circleViewRadius
        circleView.backgroundColor = .white
        
        self.circleImageView = UIImageView(frame: .zero)
        circleImageView.layer.cornerRadius = circleViewRadius
        circleImageView.isUserInteractionEnabled = false
        circleImageView.contentMode = .center
        
        circleView.addSubview(circleImageView)
        self.view.addSubview(circleView)
        
        circleView.layer.shadowOffset = CGSize(width: 0, height: 0)
        circleView.layer.shadowRadius = 2
        circleView.layer.shadowColor = UIColor.black.cgColor
        circleView.layer.shadowOpacity = 0.15
        
        let bottomPadding = getBottomPadding()
        
        circleView.frame = CGRect(
            x: tabWidth / 2 - tabWidth*0.25,
            y: self.tabBar.frame.origin.y - bottomPadding - circleViewWidth*0.5,
            width: circleViewWidth,
            height: circleViewWidth)
        circleImageView.frame = self.circleView.bounds
    }
    
    fileprivate func getBottomPadding() -> CGFloat {
        if #available(iOS 13.0, *) {
            let window = UIApplication.shared.windows[0]
            return window.safeAreaInsets.bottom
        } else if #available(iOS 11.0, *) {
            return view.safeAreaInsets.bottom
        } else { return 0 }
    }
}

extension SHCircleBarController {
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
        
        //Video Short
        let tiktokController = VideoShortRouter.setupModule()
        
        tiktokController.tabBarItem.tag = 0
        tiktokController.tabBarItem.title  = "Wow"
        tiktokController.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: verticalSize)
        tiktokController.tabBarItem.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tiktokController.tabBarItem.image = UIImage(systemName: "infinity")?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        tiktokController.tabBarItem.selectedImage = UIImage(named: "infinity")?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate).withTintColor(.systemIndigo)
        let tiktokNavController = BaseNavigationViewController(rootViewController: tiktokController)
        tiktokNavController.setHiddenNavigationBarViewControllers([VideoShortViewController.self])
        
        //Daily news
        let dailyNewsController = DailyNewsRouter.setupModule()
        dailyNewsController.tabBarItem.tag = 0
        dailyNewsController.tabBarItem.title  = "News"
        dailyNewsController.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: verticalSize)
        dailyNewsController.tabBarItem.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        dailyNewsController.tabBarItem.image = UIImage(systemName: "newspaper.fill")?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        dailyNewsController.tabBarItem.selectedImage = UIImage(named: "newspaper.fill")?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate).withTintColor(.systemIndigo)
        let newsNavController = BaseNavigationViewController(rootViewController: dailyNewsController)
        newsNavController.setHiddenNavigationBarViewControllers([])
        
        //Discorver
        let discoveryController = AdvancedSearchingRouter.setupModule()

        discoveryController.tabBarItem.tag = 0
        discoveryController.tabBarItem.title  = "Khám phá"
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
//            tiktokController,
            dailyNewsController,
            discoveryController,
            profileViewcontroller
        ]
    }
}
