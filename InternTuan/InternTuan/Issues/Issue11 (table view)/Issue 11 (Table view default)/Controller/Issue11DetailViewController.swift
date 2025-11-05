//
//  Issue11DetailViewController.swift
//  InternTuan
//
//  Created by Nguên Bản on 24/10/25.
//

import UIKit

class Issue11DetailViewController: UIViewController {

    @IBOutlet private weak var nameLabel: UILabel!
    private var name: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
    
    static func instantiate(name: String) -> Issue11DetailViewController {
        let vc = Issue11DetailViewController(nibName: StringConstants.viewController.issue11DetailVC, bundle: nil)
        vc.name = name
        return vc
    }
}

//MARK: setup
extension Issue11DetailViewController {
    private func setupUI() {
        if let name = self.name {
            self.nameLabel.text = name
        }
    }
}
