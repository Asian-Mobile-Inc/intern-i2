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
    case fourth
    case fifth
    
    // UI Metadata (Dùng để hiển thị lên View)
    var title: String {
        switch self {
        case .home: return "Home"
        case .search: return "Search"
        case .profile: return "Profile"
        case .fourth: return "Fourth"
        case .fifth: return "Fifth"
        }
    }
    
    var color: UIColor {
        switch self {
        default: return .white
        }
    }
    
    var icon: UIImage? {
        switch self {
        case .home: return UIImage(systemName: "house")
        case .search: return UIImage(systemName: "magnifyingglass")
        case .profile: return UIImage(systemName: "person")
        case .fourth: return UIImage(systemName: "message")
        case .fifth: return UIImage(systemName: "person.crop.circle")
        }
    }
    
    var selectedIcon: UIImage? {
        switch self {
        case .home: return UIImage(systemName: "house.fill")
        case .search: return UIImage(systemName: "magnifyingglass") // Một số icon không có fill
        case .profile: return UIImage(systemName: "person.fill")
        case .fourth: return UIImage(systemName: "message.fill")
        case .fifth: return UIImage(systemName: "person.crop.circle.fill")
        }
    }
}

