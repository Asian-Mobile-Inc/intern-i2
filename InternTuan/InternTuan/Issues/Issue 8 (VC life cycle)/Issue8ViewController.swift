//  Issue8ViewController.swift
//  InternTuan
//
//  Created by Nguên Bản on 1/10/25.
//

import UIKit
import OSLog

class Issue8ViewController: UIViewController {
    
    @IBOutlet private weak var childVCButton: UIButton!
    @IBOutlet private weak var changeModeButton: UIButton!
    @IBOutlet private weak var changeWidthButtonWidth: NSLayoutConstraint!
    @IBOutlet private weak var greyView: UIView!
    @IBOutlet private weak var greyViewTrailingSATrailingConstraint: NSLayoutConstraint!
    
    var didAddChildVC = false
    
    let logger = Logger()
    
    var isTooLong: Bool = false
    
    var isDarkMode: Bool = false {
        didSet {
            overrideUserInterfaceStyle = isDarkMode ? .dark : .light
            self.changeModeButton.setTitle(isDarkMode ? "light mode" : "dark mode", for: .normal)
        }
    }
    
    @IBOutlet private weak var headerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        logger.log("Issue 8 VC view did load")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.greyViewTrailingSATrailingConstraint.constant = self.view.frame.size.width
        logger.log("Issue 8 VC view will appear")
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        logger.log("Issue 8 VC view will layout subviews")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        logger.log("Issue 8 VC view did layout subviews")
        self.greyView.backgroundColor = UIColor.red
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.greyViewTrailingSATrailingConstraint.constant = 0
        UIView.animate(withDuration: 0.6,
                       delay: 0.1,
                       animations: {
            self.view.layoutIfNeeded()
        })
        logger.log("Issue 8 VC view did appear")
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        logger.log("Issue 8 VC view will disappear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        logger.log("Issue 8 VC view did disappear")
        self.greyViewTrailingSATrailingConstraint.constant = self.view.frame.size.width
    }
    
    static func instantiate() -> Issue8ViewController {
        return Issue8ViewController(nibName: "Issue8ViewController", bundle: nil)
    }
    
    private func addChildVC () {
        let childVc = Issue8ChildViewController.instantiate()
        addChild(childVc)
        
        self.headerView.addSubview(childVc.view)
        
        childVc.view.frame = self.headerView.bounds
        childVc.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        childVc.didMove(toParent: self)
    }
    
    private func removeChildVC () {
        for vc in children where vc is Issue8ChildViewController {
            vc.willMove(toParent: nil)
            vc.view.removeFromSuperview()
            vc.removeFromParent()
        }
    }
    
    @IBAction private func tapPresent(_ sender: Any) {
        logger.log("did tap present")
        let vc = Issue8PresentViewController.instantiate()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction private func tapPush(_ sender: Any) {
        let vc = Issue8PresentViewController.instantiate()
        self.navigationController?.pushViewController(vc, animated: true)
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
    
    @IBAction private func tapChangeModeButton(_ sender: Any) {
        self.isDarkMode.toggle()
    }
    
    @IBAction private func tapChangeWidthButton(_ sender: Any) {
        view.setNeedsUpdateConstraints()
    }
    
    override func viewSafeAreaInsetsDidChange() {
        debugPrint("safe area did change")
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        debugPrint("traint collection did change")
    }
    
    override func updateViewConstraints() {
        self.changeWidthButtonWidth.constant = isTooLong ? 150 : 200
        self.isTooLong.toggle()
        super.updateViewConstraints()
    }
    
    deinit{
        logger.log("Issue 8 VC deinit")
    }
    
    
    
}
