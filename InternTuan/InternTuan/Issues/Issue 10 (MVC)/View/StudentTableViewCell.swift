//
//  StudentTableViewCell.swift
//  InternTuan
//
//  Created by Nguên Bản on 20/10/25.
//

import UIKit

class StudentTableViewCell: UITableViewCell {

    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    public func render(student: Student) {
        self.nameLabel.text = student.name
        self.phoneLabel.text = String(student.age)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
