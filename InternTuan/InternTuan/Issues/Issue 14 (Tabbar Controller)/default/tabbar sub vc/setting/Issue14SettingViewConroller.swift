//
//  Issue14SettingViewConroller.swift
//  InternTuan
//
//  Created by Nguên Bản on 24/11/25.
//

import UIKit

final class Issue14SettingViewConroller: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    static func instantiate() -> Issue14SettingViewConroller {
        return Issue14SettingViewConroller(nibName: StringConstants.viewController.issue14SettingVC, bundle: nil)
    }
    
}
