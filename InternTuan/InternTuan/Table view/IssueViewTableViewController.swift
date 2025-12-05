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

    private var issueViewIdentifiers: [String] = ["Issue1n2ViewController",
                                                  "Issue1n2ViewController",
                                                  "Issue3ViewController",
                                                  "Issue4ViewController",
                                                  "Issue5ViewController"
    ]
    
    private let issueFactories: [() -> UIViewController] = [
        { Issue6ViewController.instantiate() },
        { Issue7ViewController.instantiate() },
        { Issue8ViewController.instantiate() },
        { Issue9ViewController.instantiate() },
        { Issue10ViewController.instantiate() },
        { Issue11MainViewController.instantiate() },
        { Issue12ViewController.instantiate() },
        { Issue13MainViewController.instantiate() },
        { Issue14MainViewController.instantiate() },
        {
            let repository = UserRepository()
            let viewModel = Issue15MainViewModel(repository: repository)
            return Issue15MainViewController.instantiate(viewModel: viewModel)
        }
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.backBarButtonItem?.tintColor = UIColor.black
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.issueViewIdentifiers.count + issueFactories.count
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
        if (index < issueViewIdentifiers.count) {
            if let storyboard = self.storyboard {
                let identifier = self.issueViewIdentifiers[index]
                let vc = storyboard.instantiateViewController(withIdentifier: identifier)
                self.navigationController?.pushViewController(vc, animated: true)
            }
        } else {
            let factoryIndex = index - self.issueViewIdentifiers.count
            let vc = issueFactories[factoryIndex]()
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
