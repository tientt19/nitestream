//
//  BaseNavigationViewController.swift
//  ChuaTeHoiDongQuanTri
//
//  Created by Valerian on 25/03/2022.
//

import UIKit

class BaseNavigationViewController: UINavigationController {
    
    var listViewControllerHiddenNavBar: [UIViewController.Type] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        self.navigationBar.isTranslucent = false
        self.navigationBar.layer.masksToBounds = false
        self.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationBar.shadowImage = UIImage()
        self.navigationBar.update(backroundColor: UIColor(hex: "00C2C5"), titleColor: .white)
        
        self.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.white
        ]
        
        self.navigationItem.backBarButtonItem?.title = ""
        self.changeTitleColor(to: .white)
        self.delegate = self
    }
    
    func setHiddenNavigationBarViewControllers(_ viewControllers: [UIViewController.Type]) {
        self.listViewControllerHiddenNavBar = viewControllers
    }
    
    func addHiddenNavigationBarViewController(_ viewController: UIViewController.Type) {
        self.listViewControllerHiddenNavBar.append(viewController)
    }
    
}

// MARK: UINavigationControllerDelegate
extension BaseNavigationViewController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        let isHidden = self.listViewControllerHiddenNavBar.first(where: { viewController.isKind(of: $0.self) }) != nil
        navigationController.setNavigationBarHidden(isHidden, animated: true)
    }
}

extension UINavigationBar {
    func update(backroundColor: UIColor? = nil, titleColor: UIColor? = nil) {
        if #available(iOS 15, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.shadowColor = .clear
            
            if let backroundColor = backroundColor {
                appearance.backgroundColor = backroundColor
            }
            
            if let titleColor = titleColor {
                appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: titleColor]
            }
            
            self.standardAppearance = appearance
            self.scrollEdgeAppearance = appearance
            
        }
    }
}

extension UINavigationController {
    func changeBackgroundColor(to color: UIColor?) {
        self.navigationBar.barTintColor = color
    }
    
    func changeTintColor(to color: UIColor?) {
        self.navigationBar.tintColor = color
    }
    
    func changeBarTintColor(to color: UIColor?) {
        self.navigationBar.barTintColor = color
    }
    
    func changeTitleColor(to color: UIColor) {
        self.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: color]
    }
    
    func setSeperatorLineHidden(_ isHidden: Bool) {
        self.navigationBar.setValue(isHidden, forKey: "hidesShadow")
    }
}

