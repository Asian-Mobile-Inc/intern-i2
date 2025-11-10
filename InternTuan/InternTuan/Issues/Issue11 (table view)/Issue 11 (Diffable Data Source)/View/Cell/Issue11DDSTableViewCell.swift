//
//  Issue11DDSTableViewCell.swift
//  InternTuan
//
//  Created by Nguên Bản on 30/10/25.
//

import UIKit

class Issue11DDSTableViewCell: UITableViewCell {

    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var ageLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    public func render(_ developer: Developer) {
        var name: String = ""
        if (developer.age <= 22) {
            name = "\(developer.name)\n\(developer.name)\n\(developer.name)"
        } else {
            name = developer.name
        }
        self.nameLabel.text = name
        self.ageLabel.text = String(developer.age)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            self.backgroundColor = UIColor.lightGray
            self.nameLabel.textColor = UIColor.systemPink
            self.ageLabel.textColor = UIColor.systemPink
        } else {
            self.backgroundColor = UIColor.systemBackground
            self.nameLabel.textColor = UIColor.black
            self.ageLabel.textColor = UIColor.black
        }
    }
}
