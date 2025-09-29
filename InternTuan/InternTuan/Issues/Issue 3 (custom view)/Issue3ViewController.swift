//
//  Issue3ViewController.swift
//  InternTuan
//
//  Created by TO on 15/09/2025.
//

import UIKit

class Issue3ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let anhThanh = MyImageTitleView(frame: CGRect(x: 75,
                                                              y: 100,
                                                              width: 100,
                                                              height: 125))
        self.view.addSubview(anhThanh)
        
        let quaDau = MyImageTitleView(frame: CGRect(x: 225,
                                                    y: 100,
                                                    width: 100,
                                                    height: 125))
        quaDau.avatar?.image = UIImage(named: "quaDau")
        quaDau.label?.text = "qua dau"
        self.view.addSubview(quaDau)
        
        if let userView = Bundle.main.loadNibNamed("ContactView", owner: self, options: nil)?.first as? ContactView {
            userView.frame = CGRect(x: 75, y: 250, width: 100, height: 125)
            userView.tableViewDlg = self
            self.view.addSubview(userView)
        }
    }
}

extension Issue3ViewController: ContactViewDelegate {
    func didTap(count: Int) {
        debugPrint("count = \(count)")
    }
}
