//
//  IssueViewTableViewController.swift
//  InternTuan
//
//  Created by TO on 15/09/2025.
//

import UIKit
import Foundation

protocol tableViewCellProtocol: AnyObject {
    func didTapCell(index: Int)
}

class IssueViewTableViewController: UITableViewController {

    private var issueViewIdentifiers: [String] = ["Issue12ViewController", "Issue12ViewController", "Issue3ViewController"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.issueViewIdentifiers.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "IssueViewsTableViewCell", for: indexPath) as! IssueViewsTableViewCell
        
        cell.render(title: "Issue \(indexPath.item + 1)", index: indexPath.item)
        cell.tableViewDlg = self
        
        return cell
    }
}

extension IssueViewTableViewController: tableViewCellProtocol {
    func didTapCell(index: Int) {
        if let storyboard = self.storyboard {
            if storyboard.instantiateViewController(withIdentifier: self.issueViewIdentifiers[index]) != nil {
                let vc = storyboard.instantiateViewController(withIdentifier: self.issueViewIdentifiers[index])
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
        
    }
}
