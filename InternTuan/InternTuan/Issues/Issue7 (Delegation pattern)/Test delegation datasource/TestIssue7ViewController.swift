//
//  TestIssue7ViewController.swift
//  InternTuan
//
//  Created by Nguên Bản on 25/9/25.
//

import UIKit

class TestIssue7ViewController: UIViewController {

    weak var isue7Dts: Issue7ToTestDts?
    weak var isue7Dlg: TestViewIssue7View?
    
    @IBOutlet private weak var centerView: UIView!
    @IBOutlet private weak var label: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        if let datasource = self.isue7Dts {
            self.label.text = "\(datasource.getCount())"
            self.centerView.backgroundColor = self.isue7Dts?.getColor()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let datasource = self.isue7Dts {
            self.label.text = "\(datasource.getCount())"
            self.centerView.backgroundColor = self.isue7Dts?.getColor()
        }
    }
    
    @IBAction private func tapResetNumInA(_ sender: Any) {
        self.isue7Dlg?.resetNumInA()
    }
    
    static func initinate() -> TestIssue7ViewController {
        return TestIssue7ViewController(nibName: "TestIssue7ViewController", bundle: nil)
    }
    
    deinit {
        debugPrint("bien mat roi bb")
    }
}
