//
//  HeaderView.swift
//  InternTuan
//
//  Created by Nguên Bản on 3/11/25.
//

import UIKit

class HeaderView: UITableViewHeaderFooterView {

    @IBOutlet private weak var countLbel: UILabel!
    var section: Issue11DDSViewController.Section?
    var count: Int = 0

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    public func render(_ count: Int) {
        self.count = count
        if count == 2 {
            self.countLbel.text = "short"
        } else {
            self.countLbel.text = "long---long---long   long---long---long   long---long---long"
        }
    }
}
