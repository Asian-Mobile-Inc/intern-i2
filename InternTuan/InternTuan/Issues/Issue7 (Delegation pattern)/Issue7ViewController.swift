//
//  Issue7ViewController.swift
//  InternTuan
//
//  Created by Nguên Bản on 25/9/25.
//

import UIKit

protocol Issue7ToTestDts: AnyObject {
    func getCount() -> Int
    func getColor() -> UIColor
}

protocol TestViewIssue7View: AnyObject {
    func resetNumInA()
}

class Issue7ViewController: UIViewController {

    @IBOutlet weak var demoBVCView: UIView!
    @IBOutlet weak var demoNum: UILabel!
    @IBOutlet var colorViews: [UIView]!
    
    var count = 0 {
        didSet {
            self.demoNum.text = "\(self.count)"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.resetColorView()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            if let view = touch.view {
                self.demoBVCView.backgroundColor = touch.view?.backgroundColor
                if (touch.view?.layer.cornerRadius != 20) {
                    self.resetColorView()
                    UIView.animate(withDuration: 0.3, animations: {
                        touch.view?.layer.cornerRadius = 20
                    })
                }
                if (view == self.view) {
                    self.demoBVCView.backgroundColor = UIColor.gray
                    self.resetColorView()
                }
            }
        }
    }
    
    private func resetColorView() {
        for view in colorViews {
            UIView.animate(withDuration: 0.3, animations: {
                view.layer.cornerRadius = view.frame.size.width / 2
            })
        }
    }
    
    @IBAction func tapGoToViewB(_ sender: Any) {
        
        let vc = TestIssue7ViewController.initinate()
        vc.isue7 = self
        vc.isue7Dlg = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func tapSubButton(_ sender: Any) {
        self.count -= 1
    }
    
    @IBAction func tapPlusItem(_ sender: Any) {
        self.count += 1
    }
 
    static func instantiate() -> Issue7ViewController {
        return Issue7ViewController(nibName: "Issue7ViewController", bundle: nil)
    }
}

extension Issue7ViewController: Issue7ToTestDts {
    func getCount() -> Int {
        return self.count
    }
    
    func getColor() -> UIColor {
        return self.demoBVCView.backgroundColor ?? UIColor.white
    }
}

extension Issue7ViewController: TestViewIssue7View {
    func resetNumInA() {
        self.count = 0
    }
}
