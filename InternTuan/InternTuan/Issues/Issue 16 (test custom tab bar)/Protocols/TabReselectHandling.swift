//
//  Tab.swift
//  InternTuan
//
//  Created by Tuan on 10/2/26.
//

import Foundation
import UIKit

/// Protocol xử lý logic khi người dùng chọn lại tab đang active
protocol TabReselectHandling {
    /// Hàm được gọi khi tab được select lại
    func handleReselect()
}

// Extension mặc định cho UINavigationController để tự động chuyển tiếp sự kiện
// xuống Top ViewController nếu nó có conform protocol này.
extension UINavigationController: TabReselectHandling {
    func handleReselect() {
        if let handler = topViewController as? TabReselectHandling {
            handler.handleReselect()
        } else if viewControllers.count > 1 {
            // Default behavior: Pop to root if not at root
            popToRootViewController(animated: true)
        }
        // Có thể thêm default behavior: Scroll to top nếu đang ở root
    }
}
