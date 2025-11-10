//
//  Issue11MainViewController.swift
//  InternTuan
//
//  Created by Nguên Bản on 5/11/25.
//

import UIKit

final class Issue11MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    static func instantiate() -> Issue11MainViewController {
        return Issue11MainViewController(nibName: StringConstants.viewController.issue11MainVC, bundle: nil)
    }
}

//MARK: IBAction
extension Issue11MainViewController {
    @IBAction private func tapUITBDataSourceButton() {
        let vc = Issue11ViewController.instantiate()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction private func tapUITBDiffableDataSourceButton() {
        let vc = Issue11DDSViewController.instantiate()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction private func tapDragNDropStackViewButton() {
        let vc = Issue11DragNDropViewController.instantiate()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
