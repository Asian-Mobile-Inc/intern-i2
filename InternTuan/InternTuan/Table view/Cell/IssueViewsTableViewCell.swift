//
//  IssueViewsTableViewCell.swift
//  InternTuan
//
//  Created by TO on 15/09/2025.
//

import UIKit

class IssueViewsTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    private var index: Int = 0
    
    weak var tableViewDlg: tableViewCellProtocol?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func render(title: String, index: Int) {
        self.titleLabel.text = title
        self.index = index
    }
    
    @IBAction func tapItem(_ sender: Any) {
        self.tableViewDlg?.didTapCell(index: self.index)
    }
}
