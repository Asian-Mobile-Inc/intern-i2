//
//  TabCoordinator.swift
//  InternTuan
//
//  Created by Tuan on 10/2/26.
//

import Foundation
import UIKit

final class TabCoordinator {

    private(set) var selectedTab: Tab?
    private var cache: [Tab: UIViewController] = [:]
    
    private let factory: ViewControllerFactory
    weak var delegate: CustomTabBarDelegate?
    
    init(factory: ViewControllerFactory = Issue16ViewControllerFactory()) {
        self.factory = factory
    }

    func select(tab: Tab, in controller: CustomTabController) {
        if selectedTab == tab {
            // Logic Reselect: Nếu tab đã chọn rồi -> gọi handleReselect
            if let currentVC = cache[tab] as? TabReselectHandling {
                currentVC.handleReselect()
            }
            return
        }
        
        // Logic Switch Tab (giữ nguyên)
        let oldVC = selectedTab.flatMap { cache[$0] }
        let newVC: UIViewController
        
        if let cachedVC = cache[tab] {
            newVC = cachedVC
        } else {
            newVC = factory.makeViewController(for: tab, tabBarDelegate: delegate)
            cache[tab] = newVC
        }
        
        // Switch logic: Add child -> Animation -> Remove old
        
        // 1. Prepare new VC
        controller.add(child: newVC, to: controller.contentContainerView)
        // Set trạng thái ban đầu cho animation: Hiện lên nhưng trong suốt
        newVC.view.isHidden = false
        newVC.view.alpha = 0
        
        // 2. Transition
        // Bắt đầu quy trình chuyển đổi view
        oldVC?.beginAppearanceTransition(false, animated: true)
        newVC.beginAppearanceTransition(true, animated: true)
        
        // Thực hiện Animation Cross-Dissolve (Mờ dần cái cũ -> Hiện dần cái mới)
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseInOut) {
            newVC.view.alpha = 1
            oldVC?.view.alpha = 0
        } completion: { _ in
            // Dọn dẹp sau khi animation xong
            oldVC?.view.isHidden = true
            oldVC?.view.alpha = 1 // Reset alpha để lần sau hiện lại nó không bị vô hình
            
            // Kết thúc quy trình chuyển đổi view
            oldVC?.endAppearanceTransition()
            newVC.endAppearanceTransition()
        }
        
        // 3. Update state
        selectedTab = tab
    }
}
