//  Issue8ViewController.swift
//  InternTuan
//
//  Created by Nguên Bản on 1/10/25.
//

import UIKit
import OSLog

class Issue8ViewController: UIViewController {
    
    @IBOutlet private weak var childVCButton: UIButton!
    
    var didAddChildVC = false
    
    let logger = Logger()
    
    let childVc = Issue8ChildViewController.instantiate()
    
    @IBOutlet private weak var headerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        logger.log("Issue 8 VC view did load")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        logger.log("Issue 8 VC view will appear")
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        logger.log("Issue 8 VC view will layout subviews")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        logger.log("Issue 8 VC view did layout subviews")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        logger.log("Issue 8 VC view did appear")
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        logger.log("Issue 8 VC view will disappear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        logger.log("Issue 8 VC view did disappear")
    }
    
    static func instantiate() -> Issue8ViewController {
        return Issue8ViewController(nibName: "Issue8ViewController", bundle: nil)
    }
    
    private func addChildVC () {
        addChild(childVc)
        
        self.headerView.addSubview(childVc.view)
        
        childVc.view.frame = self.headerView.bounds
        childVc.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        childVc.didMove(toParent: self)
    }
    
    private func removeChildVC () {
        childVc.willMove(toParent: nil)
        childVc.view.removeFromSuperview()
        childVc.removeFromParent()
    }
    
    @IBAction private func tapPresent(_ sender: Any) {
        logger.log("did tap present")
        let vc = Issue8PresentViewController.instantiate()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction private func tapAddChildVC(_ sender: Any) {
        self.didAddChildVC = !self.didAddChildVC
        if self.didAddChildVC {
            self.childVCButton.setTitle("Remove child VC", for: .normal)
            self.addChildVC()
        } else {
            self.childVCButton.setTitle("Add child VC", for: .normal)
            self.removeChildVC()
        }
    }
    
    deinit{
        logger.log("Issue 8 VC deinit")
    }
    
}
