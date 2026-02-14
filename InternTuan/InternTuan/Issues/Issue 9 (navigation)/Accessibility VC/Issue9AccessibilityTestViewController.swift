//
//  Issue9AccessibilityTestViewController.swift
//  InternTuan
//
//  Created by Nguên Bản on 13/10/25.
//

import UIKit

class Issue9AccessibilityTestViewController: UIViewController {

    @IBOutlet private weak var dieuBacHoDayLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "accessibility tesst"
        dieuBacHoDayLabel.adjustsFontForContentSizeCategory = true
        dieuBacHoDayLabel.translatesAutoresizingMaskIntoConstraints = false
        dieuBacHoDayLabel.font = UIFont.preferredFont(forTextStyle: .body)
    }

    static func instantiate() -> Issue9AccessibilityTestViewController {
        return Issue9AccessibilityTestViewController(nibName: "Issue9AccessibilityTestViewController", bundle: nil)
    }
    
}
