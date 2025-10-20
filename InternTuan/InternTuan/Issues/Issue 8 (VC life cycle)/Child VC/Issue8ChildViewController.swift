//
//  Issue8ChildViewController.swift
//  InternTuan
//
//  Created by Nguên Bản on 1/10/25.
//

import UIKit

class Issue8ChildViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    static func instantiate() -> Issue8ChildViewController {
        return Issue8ChildViewController(nibName: "Issue8ChildViewController", bundle: nil)
    }

    override func didMove(toParent parent: UIViewController?) {
        debugPrint("issue 8 child vc is in \(String(describing: parent))")
    }
    
    override func willMove(toParent parent: UIViewController?) {
        debugPrint("issue 8 child vc did move from \(String(describing: parent))")
    }
}
