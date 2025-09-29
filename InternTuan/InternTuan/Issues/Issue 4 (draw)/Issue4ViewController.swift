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
        let rectView = RectangularView(frame: CGRect(x: self.view.frame.size.width / 2 - 50,
                                                     y: 150,
                                                     width: 100,
                                                     height: 100))
        let rectView2 = RectangularView2(frame: CGRect(x: self.view.frame.size.width / 2 - 50,
                                                       y: 300,
                                                       width: 100,
                                                       height: 100))
        self.view.addSubview(rectView2)
        self.view.addSubview(rectView)
    }

}
