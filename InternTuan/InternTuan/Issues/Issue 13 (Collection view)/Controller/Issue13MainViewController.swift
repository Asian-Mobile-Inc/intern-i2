//
//  Issue13MainViewController.swift
//  InternTuan
//
//  Created by Nguên Bản on 11/11/25.
//

import UIKit

final class Issue13MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
 
    static func instantiate() -> Issue13MainViewController {
        return Issue13MainViewController(nibName: StringConstants.viewController.issue13VC, bundle: nil)
    }
    
}

//MARK: IBAction
extension Issue13MainViewController {
    @IBAction private func tapAutoHeightButton() {
        let vc = AutoHeightCellViewController.instantiate()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction private func tapCompositionalButton() {
        let vc = Issue13CompositionalLayoutViewController.instantiate()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
