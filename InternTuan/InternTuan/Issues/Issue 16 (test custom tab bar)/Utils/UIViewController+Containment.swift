//
//  UIViewController+Containment.swift
//  InternTuan
//
//  Created by Tuan on 10/2/26.
//

import Foundation
import UIKit

extension UIViewController {

    func add(child: UIViewController, to containerView: UIView) {
        addChild(child)
        containerView.addSubview(child.view)
        child.view.frame = containerView.bounds
        child.didMove(toParent: self)
    }

    func removeFromParentContainer() {
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
}
