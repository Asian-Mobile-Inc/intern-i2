//
//  Issue11DDSViewController.swift
//  InternTuan
//
//  Created by Nguên Bản on 30/10/25.
//

import UIKit

class Issue11DDSViewController: UIViewController {

    enum Section: String {
        case android = "Android"
        case iOS = "iOS"
    }
    
    let iosDev = [Developer(name: "anh Thanh", age: 22), Developer(name: "Tuan", age: 21)]
    let androidDev = [Developer(name: "anh Vien", age: 23), Developer(name: "anh Tuan", age: 23), Developer(name: "anh Long", age: 23), Developer(name: "anh Huy", age: 22), Developer(name: "Hoang", age: 21)]
    
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    private var dataSource: UITableViewDiffableDataSource<Section, Developer>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        configureDataSource()
        applyInitialSnapshot()
        
//        self.tableView.isEditing = true
    }
    
    static func instantiate() -> Issue11DDSViewController {
        return Issue11DDSViewController(nibName: StringConstants.viewController.issue11DDSVC, bundle: nil)
    }
}

//MARK: setup
extension Issue11DDSViewController {
    private func setupTableView() {
        let nib = UINib(nibName: StringConstants.tableViewCell.issue11DDScell, bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: StringConstants.tableViewCell.issue11DDScell)
        
        self.tableView.delegate = self
    }
    
    private func configureDataSource() {
        self.dataSource = UITableViewDiffableDataSource(
            tableView: self.tableView,
            cellProvider: { (tableView, indexPath, developer) -> UITableViewCell? in
                let cell = tableView.dequeueReusableCell(withIdentifier: StringConstants.tableViewCell.issue11DDScell, for: indexPath) as? Issue11DDSTableViewCell
                cell?.render(developer)
                return cell
            }
        )
    }
}

//MARK: initiate
extension Issue11DDSViewController {
    private func applyInitialSnapshot() {
        var snapShot = NSDiffableDataSourceSnapshot<Section, Developer>()
        snapShot.appendSections([.android, .iOS])
        snapShot.appendItems(androidDev, toSection: .android)
        snapShot.appendItems(iosDev, toSection: .iOS)
        dataSource.apply(snapShot, animatingDifferences: true)
    }
}

//MARK: table view data source service
extension Issue11DDSViewController {
    private func addItem(_ section: Section, _ developers: [Developer]) {
        var snapShot = dataSource.snapshot()
        snapShot.appendItems(developers, toSection: section)
        self.dataSource.apply(snapShot, animatingDifferences: true)
    }
}

//MARK: IBAction
extension Issue11DDSViewController {
    @IBAction private func tapAddButon() {
        let dev = Developer(name: "Hieu", age: 21)
        self.addItem(.android, [dev])
    }
    
    @IBAction private func tapEditButton() {
        debugPrint(self.dataSource.tableView(tableView, titleForHeaderInSection: 0))
    }
}

//MARK: table view delegate
extension Issue11DDSViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let sectionID = dataSource.snapshot().sectionIdentifiers[section]
        debugPrint(sectionID)
        switch sectionID {
        case .android:
            return "Android"
        case .iOS:
            return "iOS"
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let header = view as? UITableViewHeaderFooterView {
            header.textLabel?.font = UIFont.boldSystemFont(ofSize: 18)
            header.textLabel?.textColor = .systemBlue
        }
    }

}

