//
//  Issu10ViewController.swift
//  InternTuan
//
//  Created by Nguên Bản on 20/10/25.
//

import UIKit

final class Issue10ViewController: UIViewController {

    let studentService = StuentService()
    
    private var students: [Student] = [Student(name: "abcdef", age: 20)]
    
    @IBOutlet private weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTableView()
    }

    static func instantiate() -> Issue10ViewController {
        return Issue10ViewController(nibName: StringConstants.viewController.issue10VC, bundle: nil)
    }
    
}

//MARK: setup table view
extension Issue10ViewController {
    private func setupTableView() {
        let nib = UINib(nibName: StringConstants.tableViewCell.studentTableViewCell, bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: StringConstants.tableViewCell.studentTableViewCell)
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }
}

//MARK: ib action
extension Issue10ViewController {
    @IBAction private func tapRefreshButton() {
        if let students = studentService.fetchStudentDelegate() {
            updateUITableView(students: students)
        }
    }
}

//MARK: table view data source
extension Issue10ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.students.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: StringConstants.tableViewCell.studentTableViewCell, for: indexPath) as! StudentTableViewCell
        cell.render(student: students[indexPath.row])
        return cell
    }
}

//MARK: table view delegate
extension Issue10ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
}

//MARK: update UI
extension Issue10ViewController {
    private func updateUITableView(students: [Student]) {
        self.students = students
        self.tableView.reloadData()
    }
}
