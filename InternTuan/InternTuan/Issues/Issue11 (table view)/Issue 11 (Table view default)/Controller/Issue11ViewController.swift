//
//  Issue11ViewController.swift
//  InternTuan
//
//  Created by Nguên Bản on 24/10/25.
//

import UIKit

final class Issue11ViewController: UIViewController {

//    var names: [String] = [
//        "Tí",
//        "Tèo",
//        "Hùng",
//        "Lam",
//        "Thuỷ",
//        "Tuấn",
//        "Trung",
//        "Hạnh"
//    ]
    
    private var names: [[String]] =
    [
       [
        "Tí",
        "Tèo",
        "Hùng",
        "Lam",
        "Thuỷ",
        "Tuấn",
        "Trung",
        "Hạnh"
       ],
       [
        "Bình",
        "Khánh",
        "Toàn",
        "Tâm",
        "An",
        "Hương",
        "Huy",
        "Quang",
        "Vân",
        "Đài",
        "Tiến"
       ]
    ]
    
    private var titles = [
        "ios",
        "android"
    ]
    
    @IBOutlet private weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.setupTableView()
        self.setupHeaderView()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        debugPrint("disappear")
    }

    deinit {
        debugPrint("deinit")
    }
    
    static func instantiate() -> Issue11ViewController {
        return Issue11ViewController(nibName: StringConstants.viewController.issue11VC, bundle: nil)
    }
}

//MARK: setup
extension Issue11ViewController {
    private func setupUI() {
        title = "Issue 11"
    }
    
    private func setupTableView() {
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: StringConstants.tableViewCell.cell)
        
        self.tableView.delegate = self
        self.tableView.dataSource = self

        self.tableView.dragDelegate = self
        self.tableView.dropDelegate = self
        self.tableView.dragInteractionEnabled = true

    }
    
    private func setupHeaderView() {
        let nib = UINib(nibName: "HeaderView", bundle: nil)
        self.tableView.register(nib, forHeaderFooterViewReuseIdentifier: "HeaderView")
        self.tableView.sectionHeaderHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 36
    }
}

//MARK: table view delegate
extension Issue11ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "HeaderView") as! HeaderView
        headerView.render(section)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
}

//MARK: table view datasource
extension Issue11ViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return names.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: StringConstants.tableViewCell.cell)!
        cell.textLabel?.text = names[indexPath.section][indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let name = names[indexPath.section][indexPath.row]
        debugPrint("did tap \(name)")
        let vc = Issue11DetailViewController.instantiate(name: name)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            var names = names[indexPath.section]
            names.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if (indexPath.section == 0) {
            if (indexPath.row == 0) {
                return false
            }
        }
        return true
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        if (indexPath.section == 0) {
            if (indexPath.row == 1) {
                return false
            }
        }
        return true
    }

    func tableView(_ tableView: UITableView,
                   moveRowAt sourceIndexPath: IndexPath,
                   to destinationIndexPath: IndexPath) {
        let movedName = self.names[sourceIndexPath.section][sourceIndexPath.row]
        self.names[sourceIndexPath.section].remove(at: sourceIndexPath.row)
        self.names[destinationIndexPath.section].insert(movedName, at: destinationIndexPath.row)
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return ["t", "h", "a", "o", "v", "y"]
    }
}

extension Issue11ViewController: UITableViewDragDelegate {
    func tableView(_ tableView: UITableView, itemsForBeginning session: any UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        let dev = names[indexPath.section][indexPath.row]
        let itemProvider = NSItemProvider(object: dev as NSString)
        let dragItem = UIDragItem(itemProvider: itemProvider)
        dragItem.localObject = dev
        return [dragItem]
    }
}

extension Issue11ViewController: UITableViewDropDelegate {
    func tableView(_ tableView: UITableView, canHandle session: any UIDropSession) -> Bool {
        return session.localDragSession != nil
    }
    
    func tableView(_ tableView: UITableView, dropSessionDidUpdate session: any UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UITableViewDropProposal {
        let operation: UIDropOperation = (session.localDragSession != nil) ? .move : .copy
        return UITableViewDropProposal(operation: operation, intent: .insertAtDestinationIndexPath)
    }
    
    func tableView(_ tableView: UITableView, performDropWith coordinator: UITableViewDropCoordinator) {
        guard let destinationIndexPath = coordinator.destinationIndexPath,
              let item = coordinator.items.first,
              let sourceIndexPath = item.sourceIndexPath,
              let name = item.dragItem.localObject as? String
        else {
            return
        }
        
        tableView.performBatchUpdates {
            names[sourceIndexPath.section].remove(at: sourceIndexPath.row)
            names[destinationIndexPath.section].insert(name, at: destinationIndexPath.row)
            tableView.moveRow(at: sourceIndexPath, to: destinationIndexPath)
        }
        
        coordinator.drop(item.dragItem, toRowAt: destinationIndexPath)
    }
}
