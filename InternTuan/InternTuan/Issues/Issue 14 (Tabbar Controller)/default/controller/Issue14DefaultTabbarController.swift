//
//  Issue14DefaultTabbarController.swift
//  InternTuan
//
//  Created by Nguên Bản on 24/11/25.
//

import UIKit
import Foundation

final class Issue14DefaultTabbarController: UITabBarController {

    let centerButton = UIButton()
    var customTabbar: CustomTabbar = CustomTabbar()
    
    var customBatchTabBar = UIView()
    
    var homeButton = UIButton()
    var profileButton = UIButton()
    var settingButton = UIButton()
    
    private var didAddCenterButton = false
    private var didAddCustomTabbar = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTabbar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.setupCustomTabBarToBatchTabbar()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if (self.didAddCenterButton) {
            return
        }
        self.setupCustomTabbarView()
        setupBatchCustomTabBar(tabBarColor: UIColor.lightGray.cgColor)
        self.setupCustomTabBarToBatchTabbar()
        setupCenterButtonIfNeeded()
        self.customBatchTabBar.bringSubviewToFront(centerButton)
    }
    
    static func instantiate() -> Issue14DefaultTabbarController {
        return Issue14DefaultTabbarController(nibName: StringConstants.viewController.issue14TabbarController, bundle: nil)
    }
    
}

//MARK: setup
extension Issue14DefaultTabbarController {
    private func setupCustomTabbarView() {
        self.view.addSubview(customBatchTabBar)
        self.customBatchTabBar.frame = self.tabBar.frame
    }
    
    private func setupTabbar() {
        let homeVc = Issue14HomeViewConroller.instantiate()
        let homeNav = UINavigationController(rootViewController: homeVc)
        
        let settingVc = Issue14SettingViewConroller.instantiate()
        let settingNav = UINavigationController(rootViewController: settingVc)
        
        let profileVc = Issue14ProfileViewController.instantiate()
        let profileNav = UINavigationController(rootViewController: profileVc)

        self.delegate = self
        self.viewControllers = [homeNav, profileNav, settingNav]
        
        tabBar.backgroundImage = UIImage()
        tabBar.shadowImage = UIImage()
        tabBar.isTranslucent = true
        tabBar.backgroundColor = .clear
    }
}

extension Issue14DefaultTabbarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        print("Selected Tab : \(tabBarController.selectedIndex)")
    }
    
    private func setupCenterButtonIfNeeded() {
        guard !didAddCenterButton else {
            return
        }
        
        let buttonSize: CGFloat = tabBar.frame.size.height
        centerButton.frame = CGRect(
            x: (tabBar.frame.width - buttonSize) / 2,
            y: tabBar.frame.minY-20,
            width: buttonSize,
            height: buttonSize
        )
        centerButton.layer.cornerRadius = buttonSize / 2
        centerButton.backgroundColor = .systemBlue
        centerButton.setImage(UIImage(systemName: "plus"), for: .normal)
        centerButton.tintColor = .white

        centerButton.layer.shadowColor = UIColor.black.cgColor
        centerButton.layer.shadowOpacity = 0.3
        centerButton.layer.shadowOffset = CGSize(width: 0, height: 3)
        centerButton.layer.shadowRadius = 5

        centerButton.addTarget(self, action: #selector(centerButtonTapped), for: .touchUpInside)

        self.view.addSubview(centerButton)
        self.view.bringSubviewToFront(centerButton)
        didAddCenterButton = true
    }
    
    private func layoutCenterButton() {
        let buttonSize: CGFloat = 60
        let tabBarBounds = tabBar.bounds
        let centerX = (tabBarBounds.width - buttonSize) / 2
        let y = tabBar.frame.minY - buttonSize / 2
        centerButton.frame = CGRect(x: centerX, y: y, width: buttonSize, height: buttonSize)
        centerButton.layer.cornerRadius = buttonSize / 2
        tabBar.bringSubviewToFront(centerButton)
    }

    @objc func centerButtonTapped() {
        self.highlightItem(index: 1)
        print("Center button tapped!")
    }
}

//MARK: Custom tabbar
extension Issue14DefaultTabbarController {
    @objc func didTapHome() {
        debugPrint("did tap home")
        self.highlightItem(index: 0)
    }
    
    @objc func didTapProfile() {
        debugPrint("did tap profile")
        self.highlightItem(index: 1)
    }
    
    @objc func didTapSetting() {
        debugPrint("did tap setting")
        self.highlightItem(index: 2)
    }
    
    private func setupCustomTabBar() {
        if (!didAddCustomTabbar) {
            let nib = UINib(nibName: StringConstants.customView.customTabBar, bundle: nil)
            let customTabbar = nib.instantiate(withOwner: self, options: nil).first as! CustomTabbar
            self.customTabbar = customTabbar
            self.tabBar.addSubview(customTabbar)
            let customTabbarFrame = self.tabBar.bounds
            self.customTabbar.frame = customTabbarFrame
            tabBar.bringSubviewToFront(customTabbar)
            
            self.tabBar.addSubview(homeButton)
            self.homeButton.frame = self.customTabbar.frameOfItemAtIndex(index: 0)
            self.homeButton.addTarget(self, action: #selector(didTapHome), for: .touchUpInside)
            self.tabBar.addSubview(profileButton)
            self.profileButton.frame = self.customTabbar.frameOfItemAtIndex(index: 1)
            self.profileButton.addTarget(self, action: #selector(didTapProfile), for: .touchUpInside)
            self.tabBar.addSubview(settingButton)
            self.settingButton.frame = self.customTabbar.frameOfItemAtIndex(index: 2)
            self.settingButton.addTarget(self, action: #selector(didTapSetting), for: .touchUpInside)
            
            self.didAddCustomTabbar = true
            self.customTabbar.render()
            self.highlightItem(index: 0)
        }
    }
    
    private func setupCustomTabBarToBatchTabbar() {
        if (!didAddCenterButton) {
            let nib = UINib(nibName: StringConstants.customView.customTabBar, bundle: nil)
            let customTabbar = nib.instantiate(withOwner: self, options: nil).first as! CustomTabbar
            self.customTabbar = customTabbar
            self.customBatchTabBar.addSubview(customTabbar)
            let customTabbarFrame = self.customBatchTabBar.bounds
            self.customTabbar.frame = customTabbarFrame
            customBatchTabBar.bringSubviewToFront(customTabbar)
            
            self.customBatchTabBar.addSubview(homeButton)
            self.homeButton.frame = self.customTabbar.frameOfItemAtIndex(index: 0)
            self.homeButton.addTarget(self, action: #selector(didTapHome), for: .touchUpInside)
            self.customBatchTabBar.addSubview(profileButton)
            self.profileButton.frame = self.customTabbar.frameOfItemAtIndex(index: 1)
            self.customBatchTabBar.addSubview(settingButton)
            self.settingButton.frame = self.customTabbar.frameOfItemAtIndex(index: 2)
            self.settingButton.addTarget(self, action: #selector(didTapSetting), for: .touchUpInside)
            
            self.didAddCustomTabbar = true
            self.customTabbar.render()
            self.highlightItem(index: 0)
        }
    }
    
    private func highlightItem(index: Int) {
        if let viewControllers = self.viewControllers, viewControllers.count > index {
            self.selectedViewController = viewControllers[index]
            debugPrint(viewControllers)
        }
        self.customTabbar.pHighLightItemAtIndex(index: index)
    }
}

extension Issue14DefaultTabbarController {
    private func setupBatchCustomTabBar(tabBarColor: CGColor) {
        
        if (didAddCenterButton) {
            return
        }
        
        let path = self.getPathForTabBar(width: Int(self.tabBar.frame.width), height: Int(self.tabBar.frame.height))
        let shape = CAShapeLayer()
        shape.path = path.cgPath
        shape.lineWidth = 0
        shape.strokeColor = tabBarColor
        shape.fillColor = tabBarColor
        customBatchTabBar.layer.addSublayer(shape)
    }
    
    private func getPathForTabBar(width: Int, height: Int) -> UIBezierPath {
        let pathSize = CGSize(width: width, height: height)
        
        let graphicHeight = pathSize.height * 0.5
        let graphicWidth = pathSize.width / 3
        
        let startPointGraphic = CGPoint(
            x: 0,
            y: 0)
        
        let path = UIBezierPath()
        path.move(to: startPointGraphic)
        let starPointGraphic1 = CGPoint(
            x: pathSize.width / 6,
            y: startPointGraphic.y)
        path.addLine(to: CGPoint(
            x: pathSize.width / 6,
            y: startPointGraphic.y))
        
        let graphic1P2 = CGPoint(
            x: starPointGraphic1.x + graphicWidth,
            y: starPointGraphic1.y + graphicHeight)
        let graphic1S1 = CGPoint(
            x: starPointGraphic1.x + 0.675 * graphicWidth,
            y: starPointGraphic1.y)
        let graphic1S2 = CGPoint(
            x: starPointGraphic1.x + 0.55 * graphicWidth,
            y: starPointGraphic1.y + graphicHeight)
        
        let starPointGraphic2 = CGPoint(
            x: graphic1P2.x,
            y: graphic1P2.y)
        
        let graphic2P2 = CGPoint(
            x: starPointGraphic2.x + graphicWidth,
            y: starPointGraphic2.y - graphicHeight)
        let graphic2S1 = CGPoint(
            x: starPointGraphic2.x + 0.45 * graphicWidth,
            y: starPointGraphic2.y)
        let graphic2S2 = CGPoint(
            x: starPointGraphic2.x + 0.35 * graphicWidth,
            y: starPointGraphic2.y - graphicHeight)
        
        path.addCurve(
            to: graphic1P2,
            controlPoint1: graphic1S1,
            controlPoint2: graphic1S2)
        
        path.addCurve(
            to: graphic2P2,
            controlPoint1: graphic2S1,
            controlPoint2: graphic2S2)
        
        path.addLine(to: CGPoint(
            x: graphic2P2.x + pathSize.width / 6,
            y: graphic2P2.y))
        
        path.addLine(to: CGPoint(
            x: graphic2P2.x + pathSize.width / 6,
            y: pathSize.height))
        
        path.addLine(to: CGPoint(x: startPointGraphic.x, y: startPointGraphic.y + pathSize.height))
        path.close()
        return path
    }
}
