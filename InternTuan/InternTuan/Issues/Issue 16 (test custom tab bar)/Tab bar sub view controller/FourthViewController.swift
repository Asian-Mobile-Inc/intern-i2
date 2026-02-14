//
//  FourthViewController.swift
//  InternTuan
//
//  Created by Tuan on 11/2/26.
//

import UIKit

class FourthViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    static func instantiate() -> FourthViewController {
        return FourthViewController(nibName: "FourthViewController", bundle: nil)
    }
}
