//
//  Issue11ViewController.swift
//  InternTuan
//
//  Created by Nguên Bản on 24/10/25.
//

import UIKit

class Issue11ViewController: UIViewController {

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

        self.tableView.isEditing = true
//        self.tableView.dragDelegate = self
//        self.tableView.dropDelegate = self
//        self.tableView.dragInteractionEnabled = true

    }
}

//MARK: table view delegate
extension Issue11ViewController: UITableViewDelegate {
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
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return titles[section]
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
