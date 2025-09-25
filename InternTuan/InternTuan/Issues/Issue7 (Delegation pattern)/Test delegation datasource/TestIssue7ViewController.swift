//
//  TestIssue7ViewController.swift
//  InternTuan
//
//  Created by Nguên Bản on 25/9/25.
//

import UIKit

class TestIssue7ViewController: UIViewController {

    weak var isue7: Issue7ToTestDts?
    weak var isue7Dlg: TestViewIssue7View?
    
    @IBOutlet weak var centerView: UIView!
    @IBOutlet weak var label: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        if let datasource = self.isue7 {
            self.label.text = "\(datasource.getCount())"
            self.centerView.backgroundColor = self.isue7?.getColor()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let datasource = self.isue7 {
            self.label.text = "\(datasource.getCount())"
            self.centerView.backgroundColor = self.isue7?.getColor()
        }
    }
    
    @IBAction func tapResetNumInA(_ sender: Any) {
        self.isue7Dlg?.resetNumInA()
    }
    
    static func initinate() -> TestIssue7ViewController {
        return TestIssue7ViewController(nibName: "TestIssue7ViewController", bundle: nil)
    }
}
