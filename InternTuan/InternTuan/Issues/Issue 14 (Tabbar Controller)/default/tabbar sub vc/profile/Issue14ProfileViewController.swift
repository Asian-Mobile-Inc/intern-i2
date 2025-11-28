//
//  Issue14ProfileViewController.swift
//  InternTuan
//
//  Created by Nguên Bản on 25/11/25.
//

import UIKit

final class Issue14ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    static func instantiate() -> Issue14ProfileViewController {
        return Issue14ProfileViewController(nibName: StringConstants.viewController.issue14ProfileVC, bundle: nil)
    }
    
}
