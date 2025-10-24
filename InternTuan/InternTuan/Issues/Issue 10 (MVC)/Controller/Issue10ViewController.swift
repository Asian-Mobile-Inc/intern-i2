//
//  Issu10ViewController.swift
//  InternTuan
//
//  Created by Nguên Bản on 20/10/25.
//

import UIKit

final class Issue10ViewController: UIViewController {

    let studentService = StudentService()
    
    private var students: [Student] = []
    
    @IBOutlet private weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTableView()
        self.setupService()
        self.setupNotification()
    }

    static func instantiate() -> Issue10ViewController {
        return Issue10ViewController(nibName: StringConstants.viewController.issue10VC, bundle: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

//MARK: setup
extension Issue10ViewController {
    private func setupTableView() {
        let nib = UINib(nibName: StringConstants.tableViewCell.studentTableViewCell, bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: StringConstants.tableViewCell.studentTableViewCell)
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }
    
    private func setupService() {
        self.studentService.issue10VCDlg = self
        
        let cancelled = self.studentService.$onChange.sink(receiveValue: { string in
            debugPrint(string)
        })
        
    }
    
    private func setupNotification() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handelDidFetchStudent(_:)),
            name: .didFetchStudentList,
            object: nil
        )
    }
}

//MARK: ib action
extension Issue10ViewController {
    //MARK: notification
    @IBAction private func tapRefreshButton() {
        debugPrint("did tap refresh button (view -> controller)")
        debugPrint("call studentService to fetch student list (controller -> model)")
        self.studentService.fetchStudentListNotification()
    }

    //MARK: closure call back
    @IBAction private func tapClosureButton() {
        debugPrint("did tap refresh button (view -> controller)")
        debugPrint("call studentService to fetch student list (controller -> model)")
        self.studentService.fetchStudentClosureCallBack(completion: { [weak self] result in
            guard let self = self else {
                return
            }

            switch result {
            case .failure(let error):
                debugPrint("error: \(error)")
            case .success(let students):
                updateUITableView(students: students)
            }
        })
    }
    
    //MARK: delegate
    @IBAction private func tapDelegateButton() {
        self.studentService.fetchStudentDelegate()
    }
    
    @IBAction private func tapResetButton() {
        self.updateUITableView(students: [])
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
        debugPrint("update ui (controller -> view)")
        self.students = students
        self.tableView.reloadData()
    }
}

//MARK: issue10VcDlg
extension Issue10ViewController: Issue10ViewControllefDelegate {
    func didFetchStudent(students: [Student]) {
        self.updateUITableView(students: students)
    }
}

//MARK: handel notification
extension Issue10ViewController {
    @objc func handelDidFetchStudent( _ notification: Notification) {
        if let students = notification.userInfo?[StringConstants.notification.userInfo.students] as? [Student] {
            self.updateUITableView(students: students)
        }
    }
}
