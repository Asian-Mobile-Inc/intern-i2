//
//  Issue14DefaultTabbarController.swift
//  InternTuan
//
//  Created by Nguên Bản on 24/11/25.
//

import UIKit

class Issue14DefaultTabbarController: UITabBarController {

    let centerButton = UIButton()
    private var didAddCenterButton = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTabbar()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // Đảm bảo button được add và layout sau khi tabBar đã có kích thước cuối
        setupCenterButtonIfNeeded()
        layoutCenterButton()
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
        
        let settingVc1 = Issue14SettingViewConroller.instantiate()
        let settingNav1 = UINavigationController(rootViewController: settingVc1)
        let img = UIImage(named: "anhThanh")?
            .preparingThumbnail(of: CGSize(width: 30, height: 30))

        let imgSelected = UIImage(named: "oc")?
            .preparingThumbnail(of: CGSize(width: 30, height: 30))

        settingNav1.tabBarItem = UITabBarItem(
            title: "setting",
            image: img?.withRenderingMode(.alwaysOriginal),
            selectedImage: imgSelected?.withRenderingMode(.alwaysOriginal)
        )
        
        if let bgImage = UIImage(named: "quaDau") {
            let bgrImg = bgImage.withRenderingMode(.alwaysOriginal)
            self.tabBar.backgroundImage = bgrImg
        }
        
        self.delegate = self
        self.viewControllers = [settingNav, homeNav, settingNav1]
        
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
            x: (tabBar.bounds.width - buttonSize) / 2,
            y: -20,  // nổi lên trên tabBar
            width: buttonSize,
            height: buttonSize
        )
        centerButton.layer.cornerRadius = buttonSize / 2
        centerButton.backgroundColor = .systemBlue
        centerButton.setImage(UIImage(systemName: "plus"), for: .normal)
        centerButton.tintColor = .white

        // shadow cho nổi bật
        centerButton.layer.shadowColor = UIColor.black.cgColor
        centerButton.layer.shadowOpacity = 0.3
        centerButton.layer.shadowOffset = CGSize(width: 0, height: 3)
        centerButton.layer.shadowRadius = 5

        centerButton.addTarget(self, action: #selector(centerButtonTapped), for: .touchUpInside)

        tabBar.addSubview(centerButton)
        tabBar.bringSubviewToFront(centerButton)
        didAddCenterButton = true
    }
    
    private func layoutCenterButton() {
        // Cập nhật frame theo kích thước tabBar hiện tại, xử lý safe area
        let buttonSize: CGFloat = 60
        let tabBarBounds = tabBar.bounds
        let centerX = (tabBarBounds.width - buttonSize) / 2
        // Nổi lên 20pt so với mép trên tabBar
        let y = -20.0
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
