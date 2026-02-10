//
//  Tab.swift
//  InternTuan
//
//  Created by Tuan on 10/2/26.
//

import Foundation
import UIKit

enum Tab: Int, CaseIterable {
    case home
    case search
    case profile
    
    // UI Metadata (Dùng để hiển thị lên View)
    var title: String {
        switch self {
        case .home: return "Home"
        case .search: return "Search"
        case .profile: return "Profile"
        }
    }
    
    var color: UIColor {
        switch self {
        case .home: return .systemRed
        case .search: return .systemGreen
        case .profile: return .systemBlue
        }
    }
    
    var icon: UIImage? {
        switch self {
        case .home: return UIImage(systemName: "house")
        case .search: return UIImage(systemName: "magnifyingglass")
        case .profile: return UIImage(systemName: "person")
        }
    }
    
    var selectedIcon: UIImage? {
        switch self {
        case .home: return UIImage(systemName: "house.fill")
        case .search: return UIImage(systemName: "magnifyingglass") // Một số icon không có fill
        case .profile: return UIImage(systemName: "person.fill")
        }
    }
}

