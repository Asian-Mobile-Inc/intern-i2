//
//  Issue6ViewController.swift
//  InternTuan
//
//  Created by Nguên Bản on 24/9/25.
//

import UIKit

class Issue6ViewController: UIViewController {

    @IBOutlet private weak var quaDauImage: UIImageView!
    @IBOutlet private weak var anhThanhImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    static func instantiate() -> Issue6ViewController {
        return Issue6ViewController(nibName: "Issue6ViewController", bundle: nil)
    }

    @IBAction private func tapHiddenAnhThanhTrai(_ sender: Any) {
        anhThanhImage.isHidden.toggle()
    }
    @IBAction private func tapHiddenQuaDau(_ sender: Any) {
        quaDauImage.isHidden.toggle()
    }
}
