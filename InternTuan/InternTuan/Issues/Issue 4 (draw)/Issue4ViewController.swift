//
//  Issue4ViewController.swift
//  InternTuan
//
//  Created by TO on 16/09/2025.
//

import UIKit

class Issue4ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let rectView = RectangularView(frame: CGRect(x: 20 * 2 + 5, y: 150, width: 300, height: 300))
        
        self.view.addSubview(rectView)
    }

}
