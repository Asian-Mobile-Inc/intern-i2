//
//  FifthViewController.swift
//  InternTuan
//
//  Created by Tuan on 11/2/26.
//

import UIKit

class FifthViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    static func instantiate() -> FifthViewController {
        return FifthViewController(nibName: "FifthViewController", bundle: nil)
    }
    
}
