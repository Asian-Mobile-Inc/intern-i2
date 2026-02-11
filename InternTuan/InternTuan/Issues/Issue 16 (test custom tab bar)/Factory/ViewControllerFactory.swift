//
//  ViewControllerFactory.swift
//  InternTuan
//
//  Created by Tuan on 10/2/26.
//

import Foundation
import UIKit

protocol ViewControllerFactory {
    func makeViewController(for tab: Tab, tabBarDelegate: CustomTabBarDelegate?) -> UIViewController
}

struct Issue16ViewControllerFactory: ViewControllerFactory {
    func makeViewController(for tab: Tab, tabBarDelegate: CustomTabBarDelegate? = nil) -> UIViewController {
        let rootVC: UIViewController
        
        switch tab {
        case .home:
            rootVC = FirstViewController.instantiate(tabBarDelegate: tabBarDelegate)
        case .search:
            rootVC = SecondViewController.instantiate()
        case .profile:
            rootVC = ThirtViewController.instantiate()
        case .fourth:
            rootVC = FourthViewController.instantiate()
        case .fifth:
            rootVC = FifthViewController.instantiate()
            
        }
        
        // Wrap trong Navigation Controller để hỗ trợ push/pop
        let nav = UINavigationController(rootViewController: rootVC)
        return nav
    }
}
