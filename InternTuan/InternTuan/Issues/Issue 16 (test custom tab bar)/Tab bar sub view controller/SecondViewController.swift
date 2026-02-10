//
//  SecondViewController.swift
//  InternTuan
//
//  Created by Tuan on 9/2/26.
//

import UIKit

class SecondViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    static func instantiate() -> SecondViewController {
        return SecondViewController(nibName: "SecondViewController", bundle: nil)
    }
    
}
