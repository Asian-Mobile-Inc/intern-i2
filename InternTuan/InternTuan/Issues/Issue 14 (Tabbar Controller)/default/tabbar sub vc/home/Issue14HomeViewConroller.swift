//
//  Issue14HomeViewConroller.swift
//  InternTuan
//
//  Created by Nguên Bản on 24/11/25.
//

import UIKit

class Issue14HomeViewConroller: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    static func instantiate() -> Issue14HomeViewConroller {
        return Issue14HomeViewConroller(nibName: StringConstants.viewController.issue14HomeVC, bundle: nil)
    }

    @IBAction func tapButton(_ sender: Any) {
        debugPrint("did tap button")
    }
}
