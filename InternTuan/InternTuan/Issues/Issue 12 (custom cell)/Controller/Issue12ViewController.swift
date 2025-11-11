//
//  Issue12ViewController.swift
//  InternTuan
//
//  Created by Nguên Bản on 10/11/25.
//

import UIKit

class Issue12ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    static func instantiate() -> Issue12ViewController {
        return Issue12ViewController(nibName: StringConstants.viewController.issue12VC, bundle: nil)
    }
    
}
