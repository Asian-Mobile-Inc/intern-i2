//
//  Issue11DDSTableViewCell.swift
//  InternTuan
//
//  Created by Nguên Bản on 30/10/25.
//

protocol Issue11DDSTableViewCellDelegate: AnyObject {
    func textViewDidChange(_ cell: Issue11DDSTableViewCell)
}

import UIKit

final class Issue11DDSTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var ageLabel: UILabel!
    @IBOutlet private weak var textView: UITextView!

    var onTextChanged: ((String) -> Void)?

    weak var delegate: Issue11DDSTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        self.textView.delegate = self
    }

    public func render(_ developer: Developer) {
        var name: String = ""
        if (developer.age <= 22) {
            name = "\(developer.name)\n\(developer.name)\n\(developer.name)"
        } else {
            name = developer.name
        }
        debugPrint("config")
        self.nameLabel.text = name
        self.ageLabel.text = String(developer.age)
        self.textView.text = developer.note
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

extension Issue11DDSTableViewCell: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        self.delegate?.textViewDidChange(self)
    }
}
