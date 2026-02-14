//
//  TabBarViewController.swift
//  InternTuan
//
//  Created by Tuan on 10/2/26.
//

import UIKit

final class CustomTabController: UIViewController {

    private let coordinator: TabCoordinator
//    private let tabBarView: TabBarView
    
    // Container để chứa view của các child view controller
    let contentContainerView = UIView()
    var customTabBar = ARCustomTabBar()
    
    // Constraint bottom của tab bar để animate ẩn/hiện
    private var tabBarBottomConstraint: NSLayoutConstraint?

    init(
        coordinator: TabCoordinator,
        tabBarView: TabBarView
    ) {
        self.coordinator = coordinator
//        self.tabBarView = tabBarView
        super.init(nibName: nil, bundle: nil)
        self.coordinator.delegate = self
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        // Gắn delegate để hứng sự kiện bấm
        customTabBar.delegate = self
        
        // Select tab mặc định (Home)
        let defaultTab = Tab.home
        coordinator.select(tab: defaultTab, in: self)
        
        // Đồng bộ UI lúc đầu (highlight nút Home)
//        tabBarView.updateUI(selectedIndex: defaultTab.rawValue)
        customTabBar.updateUI(selectedTab: defaultTab)
        
        // Demo Badge: Gắn thử badge số 3 vào tab Profile chơi chơi
//        tabBarView.setBadge("3", for: .profile)
    }
    
    private func setupUI() {
        view.backgroundColor = .gray
        
        
        let customTabBarNib = UINib(nibName: "ARCustomTabBar", bundle: nil)
        self.customTabBar = customTabBarNib.instantiate(withOwner: self).first as! ARCustomTabBar
        
        
        // Setup content container
        contentContainerView.translatesAutoresizingMaskIntoConstraints = false
        contentContainerView.backgroundColor = .systemBackground
        view.addSubview(contentContainerView)
        
        // Setup tab bar view
//        tabBarView.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(tabBarView)
        
        customTabBar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(customTabBar)
        
//        let bottomConstraint = tabBarView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
//        self.tabBarBottomConstraint = bottomConstraint
        
        let bottomConstraint = customTabBar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        self.tabBarBottomConstraint = bottomConstraint
        
        

        
        
        NSLayoutConstraint.activate([
            // TabBarView constraints
            customTabBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            customTabBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomConstraint, // Dùng biến lưu trữ constraint
            customTabBar.heightAnchor.constraint(equalToConstant: 72), // Height 100 như bản cũ
            
            // ContentContainerView constraints
            contentContainerView.topAnchor.constraint(equalTo: view.topAnchor),
            contentContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            // Quan trọng: Content sẽ luôn dính đáy vào TabBar.
            // Khi TabBar đi xuống (ẩn), Content sẽ tự dãn ra theo.
            contentContainerView.bottomAnchor.constraint(equalTo: customTabBar.topAnchor, constant: 16)
        ])
        
        customTabBar.setupUI()
    }
    
    // API để ẩn hiện TabBar
    func setTabBarHidden(_ hidden: Bool, animated: Bool) {
        // Nếu ẩn -> dịch xuống 100 (chiều cao tab bar). Nếu hiện -> dịch về 0
        let constant: CGFloat = hidden ? 110 : 10
        
        // Nếu trạng thái đã đúng thì return
        if tabBarBottomConstraint?.constant == constant { return }
        
        tabBarBottomConstraint?.constant = constant
        
        // Layout ngay lập tức nếu không animation
        if !animated {
            view.layoutIfNeeded()
            return
        }
        
        // Animation layout
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    static func instantiate(
        coordinator: TabCoordinator,
        tabBarView: TabBarView
    ) -> CustomTabController {
        return CustomTabController(coordinator: coordinator, tabBarView: tabBarView)
    }
}

// MARK: - TabBarViewDelegate
extension CustomTabController: TabBarViewDelegate {
    func tabBarView(_ view: ARCustomTabBar, didSelect tab: Tab) {
        coordinator.select(tab: tab, in: self)
        customTabBar.updateUI(selectedTab: tab)
    }
    
    func tabBarView(_ view: TabBarView, didSelect tab: Tab) {
        // 1. Logic: Báo coordinator chuyển tab (xử lý ẩn hiện view)
        coordinator.select(tab: tab, in: self)
        
        // 2. UI: Báo TabBarView update trạng thái (đổi màu nút)
//        tabBarView.updateUI(selectedIndex: tab.rawValue)
    }
}

protocol CustomTabBarDelegate: AnyObject {
    func pushViewController(_ viewController: UIViewController, animated: Bool)
    func presentVC(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)?)
    func setTabBarHidden(shouldHide: Bool, animation: Bool)
}

extension CustomTabController: CustomTabBarDelegate {
    func pushViewController(_ viewController: UIViewController, animated: Bool) {
        navigationController?.pushViewController(viewController, animated: animated)
    }
    
    func presentVC(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)?) {
        self.present(viewControllerToPresent, animated: true, completion: nil)
    }
    
    func setTabBarHidden(shouldHide: Bool, animation: Bool) {
        self.setTabBarHidden(shouldHide, animated: animation)
    }
}


//let nib = UINib(nibName: StringConstants.customView.customTabBar, bundle: nil)
//let customTabbar = nib.instantiate(withOwner: self, options: nil).first as! CustomTabbar
