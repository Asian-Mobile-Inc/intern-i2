//
//  issue16ViewController.swift
//  InternTuan
//
//  Created by Nguên Bản on 9/12/25.
//

import UIKit

class issue16ViewController: UIViewController {

    @IBOutlet weak var containerView: UIView!
    
    let editor = MarkupEditorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.containerView.addSubview(editor)
        editor.frame = self.containerView.bounds
    }
    
    static func instantiate() -> issue16ViewController {
        return issue16ViewController(nibName: "issue16ViewController", bundle: nil)
    }
}
