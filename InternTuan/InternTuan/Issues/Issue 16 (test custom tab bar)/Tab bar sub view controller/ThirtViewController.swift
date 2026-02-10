//
//  ThirtViewController.swift
//  InternTuan
//
//  Created by Tuan on 9/2/26.
//

import UIKit

class ThirtViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    static func instantiate() -> ThirtViewController {
        return ThirtViewController(nibName: "ThirtViewController", bundle: nil)
    }
    
}
