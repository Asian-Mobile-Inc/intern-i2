//
//  Issue14MainViewController.swift
//  InternTuan
//
//  Created by Nguên Bản on 24/11/25.
//

import UIKit

final class Issue14MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    static func instantiate() -> Issue14MainViewController {
        return Issue14MainViewController(nibName: StringConstants.viewController.issue14MainVC, bundle: nil)
    }

}

//IBAction
extension Issue14MainViewController {
    @IBAction private func tapDefault() {
        let vc = Issue14DefaultTabbarController.instantiate()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
