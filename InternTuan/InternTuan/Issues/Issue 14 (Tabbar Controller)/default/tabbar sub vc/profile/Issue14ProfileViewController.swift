//
//  Issue14ProfileViewController.swift
//  InternTuan
//
//  Created by Nguên Bản on 25/11/25.
//

import UIKit

class Issue14ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    static func instantiate() -> Issue14ProfileViewController {
        return Issue14ProfileViewController(nibName: StringConstants.viewController.issue14ProfileVC, bundle: nil)
    }
    
}
