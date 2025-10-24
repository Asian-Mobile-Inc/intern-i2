//
//  Issue8PresentViewController.swift
//  InternTuan
//
//  Created by Nguên Bản on 1/10/25.
//

import UIKit

class Issue8PresentViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        debugPrint("Issue 8 Present VC did load")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if isMovingFromParent {
            debugPrint("pop")
        } else if isBeingDismissed {
            debugPrint("dismiss")
        }
        debugPrint("Issue 8 Present VC did disappear")
    }
    
    @IBAction private func tapDismiss(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    static func instantiate() -> Issue8PresentViewController {
        return Issue8PresentViewController(nibName: "Issue8PresentViewController", bundle: nil)
    }

}
