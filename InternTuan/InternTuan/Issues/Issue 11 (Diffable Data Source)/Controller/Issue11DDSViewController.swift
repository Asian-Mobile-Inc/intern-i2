//
//  Issue11DDSViewController.swift
//  InternTuan
//
//  Created by Nguên Bản on 30/10/25.
//

import UIKit

final class Issue11DDSViewController: UIViewController {

    enum Section: String {
        case android = "Android"
        case iOS = "iOS"
    }
    
    let iosDev = [Developer(name: "anh Thanh", age: 22), Developer(name: "Tuan", age: 21)]
    let androidDev = [Developer(name: "anh Vien", age: 23), Developer(name: "anh Tuan", age: 23), Developer(name: "anh Long", age: 23), Developer(name: "anh Huy", age: 22), Developer(name: "Hoang", age: 21)]
    
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    private var dataSource: DevDiffableDataSource!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        configureDataSource()
        applyInitialSnapshot()
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
        
        let headerNib = UINib(nibName: "HeaderView", bundle: nil)
        self.tableView.register(headerNib, forHeaderFooterViewReuseIdentifier: "HeaderView")
        
        self.tableView.delegate = self
        self.tableView.dragInteractionEnabled = true
        self.tableView.dragDelegate = self
        self.tableView.dropDelegate = self

        // Bật automatic dimension cho header
        self.tableView.sectionHeaderHeight = UITableView.automaticDimension
        self.tableView.estimatedSectionHeaderHeight = 44
    }
    
    private func configureDataSource() {
        self.dataSource = DevDiffableDataSource(
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
        let dev = [Developer(name: "Hieu", age: 21)]
        self.addItem(.android, dev)
    }
    
    @IBAction private func tapEditButton() {
        self.tableView.setEditing(!(self.tableView.isEditing), animated: true)
        let title = tableView.isEditing ? "Done" : "Edit"
        editButton.setTitle(title, for: .normal)
    }
}

//MARK: table view delegate
extension Issue11DDSViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection sectionIndex: Int) -> UIView? {
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "HeaderView") as? HeaderView else {
            return nil
        }
        
        let snapshot = dataSource.snapshot()
        let section = snapshot.sectionIdentifiers[sectionIndex]
        let items = snapshot.itemIdentifiers(inSection: section)
        headerView.section = section
        headerView.render(items.count)
        
        return headerView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        // Để Auto Layout tự tính dựa vào nội dung
        return UITableView.automaticDimension
    }
}

// MARK: - Drag & Drop Delegate
extension Issue11DDSViewController: UITableViewDragDelegate, UITableViewDropDelegate {
    
    func tableView(_ tableView: UITableView,
                   itemsForBeginning session: UIDragSession,
                   at indexPath: IndexPath) -> [UIDragItem] {
        guard let developer = dataSource.itemIdentifier(for: indexPath) else { return [] }
        let itemProvider = NSItemProvider(object: developer.name as NSString)
        let dragItem = UIDragItem(itemProvider: itemProvider)
        dragItem.localObject = developer
        debugPrint("done drag")
        return [dragItem]
    }

    func tableView(_ tableView: UITableView,
                   canHandle session: UIDropSession) -> Bool {
        return session.canLoadObjects(ofClass: NSString.self)
    }
    
    func tableView(_ tableView: UITableView,
                   performDropWith coordinator: UITableViewDropCoordinator) {
        guard let destinationIndexPath = coordinator.destinationIndexPath else {
            debugPrint("return")
            return
        }

        debugPrint("destinationIndexPath: \(destinationIndexPath)")
        
        if let item = coordinator.items.first,
           let sourceDeveloper = item.dragItem.localObject as? Developer {
            debugPrint(item)
            var snapshot = dataSource.snapshot()
            
            if let _ = snapshot.sectionIdentifier(containingItem: sourceDeveloper) {
                snapshot.deleteItems([sourceDeveloper])
            }
            
            let destinationSection = snapshot.sectionIdentifiers[destinationIndexPath.section]
            let itemsInSection = snapshot.itemIdentifiers(inSection: destinationSection)
            if destinationIndexPath.row < itemsInSection.count {
                snapshot.insertItems([sourceDeveloper], beforeItem: itemsInSection[destinationIndexPath.row])
            } else {
                snapshot.appendItems([sourceDeveloper], toSection: destinationSection)
            }
            
            dataSource.apply(snapshot, animatingDifferences: true)
        }
    }
    
    func tableView(_ tableView: UITableView,
                   dragPreviewParametersForRowAt indexPath: IndexPath) -> UIDragPreviewParameters? {
        let parameters = UIDragPreviewParameters()
        parameters.visiblePath = UIBezierPath(roundedRect: tableView.cellForRow(at: indexPath)?.bounds ?? .zero, cornerRadius: 12)
        return parameters
    }
}
