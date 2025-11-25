//
//  Issue14DefaultTabbarController.swift
//  InternTuan
//
//  Created by Nguên Bản on 24/11/25.
//

import UIKit

class Issue14DefaultTabbarController: UITabBarController {

    let centerButton = UIButton()
    var customTabbar: CustomTabbar = CustomTabbar()
    
    var homeButton = UIButton()
    var profileButton = UIButton()
    var settingButton = UIButton()
    
    private var didAddCenterButton = false
    private var didAddCustomTabbar = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTabbar()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // Đảm bảo button được add và layout sau khi tabBar đã có kích thước cuối
//        setupCenterButtonIfNeeded()
//        layoutCenterButton()
        
        setupCustomTabBar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
//        self.highlightItem(index: 0)
    }
    
    static func instantiate() -> Issue14DefaultTabbarController {
        return Issue14DefaultTabbarController(nibName: StringConstants.viewController.issue14TabbarController, bundle: nil)
    }
    
}

//MARK: setup
extension Issue14DefaultTabbarController {
    private func setupTabbar() {
        let homeVc = Issue14HomeViewConroller.instantiate()
        let homeNav = UINavigationController(rootViewController: homeVc)
        homeNav.tabBarItem = UITabBarItem(tabBarSystemItem: .featured, tag: 0)
        
        let settingVc = Issue14SettingViewConroller.instantiate()
        let settingNav = UINavigationController(rootViewController: settingVc)
        let quaDauImg = UIImage(named: "quaDau")?
            .preparingThumbnail(of: CGSize(width: 30, height: 30))
        settingNav.tabBarItem = UITabBarItem(
            title: "",
            image: quaDauImg?.withRenderingMode(.alwaysOriginal),
            tag: 2)
        
        let profileVc = Issue14ProfileViewController.instantiate()
        let profileNav = UINavigationController(rootViewController: profileVc)
        let img = UIImage(named: "anhThanh")?
            .preparingThumbnail(of: CGSize(width: 30, height: 30))

        let imgSelected = UIImage(named: "oc")?
            .preparingThumbnail(of: CGSize(width: 30, height: 30))

        profileNav.tabBarItem = UITabBarItem(
            title: "setting",
            image: img?.withRenderingMode(.alwaysOriginal),
            selectedImage: imgSelected?.withRenderingMode(.alwaysOriginal)
        )
        
        if let bgImage = UIImage(named: "quaDau") {
            let bgrImg = bgImage.withRenderingMode(.alwaysOriginal)
            self.tabBar.backgroundImage = bgrImg
        }
        
        self.delegate = self
        self.viewControllers = [homeNav, profileNav, settingNav]
        
        self.tabBar.backgroundColor = .lightGray
    }
}

extension Issue14DefaultTabbarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        print("Selected Tab : \(tabBarController.selectedIndex)")
    }
    
    private func setupCenterButtonIfNeeded() {
        guard !didAddCenterButton else { return }
        
        let buttonSize: CGFloat = 60
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
        if let viewControllers = self.viewControllers, viewControllers.count > 1 {
            self.selectedViewController = viewControllers[1]
        }
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
    
    private func highlightItem(index: Int) {
        if let viewControllers = self.viewControllers, viewControllers.count > index {
            self.selectedViewController = viewControllers[index]
            debugPrint(viewControllers)
        }
        self.customTabbar.pHighLightItemAtIndex(index: index)
    }
}
