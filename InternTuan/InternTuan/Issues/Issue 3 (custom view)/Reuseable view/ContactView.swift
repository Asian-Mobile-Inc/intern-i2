//
//  ContactView.swift
//  InternTuan
//
//  Created by TO on 15/09/2025.
//

import UIKit

protocol ContactViewDelegate: AnyObject {
    func didTap(count: Int)
}

class ContactView: UIView {

    private var count: Int = 0
    
    weak var tableViewDlg: ContactViewDelegate?
    
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var label: UILabel!
    
    @IBAction private func tapContactView(_ sender: Any) {
        self.count += 1
        self.label.text = String(count)
        
        if let delegate = self.tableViewDlg {
            delegate.didTap(count: count)
        }
    }
}
