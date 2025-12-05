//
//  Issue15MainViewController.swift
//  InternTuan
//
//  Created by Nguên Bản on 28/11/25.
//

import UIKit
import Combine

final class Issue15MainViewController: UIViewController {

    private var songs: [Song] = []
    private var users: [User] = []
    private let viewModel: Issue15MainViewModel
    private var cancellables = Set<AnyCancellable>()
    
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var textField: UITextField!
    @IBOutlet private weak var fetchDataButton: UIButton!
    @IBOutlet private weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViewModel()
        self.setupTableView()
    }
    
    init (viewModel: Issue15MainViewModel) {
        self.viewModel = viewModel
        super.init(nibName: StringConstants.viewController.issue15MainVC, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    static func instantiate(viewModel: Issue15MainViewModel) -> Issue15MainViewController {
        return Issue15MainViewController(viewModel: viewModel)
    }
}

//MARK: setup
extension Issue15MainViewController {
    private func setupViewModel() {
        
        self.viewModel.$users
            .receive(on: DispatchQueue.main)
            .sink { [weak self] users in
                guard let self = self else { return }
                self.users = users
                self.tableView.reloadData()
            }
            .store(in: &cancellables)
        
        self.viewModel.$isLoading
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isLoading in
                if isLoading {
                    self?.fetchDataButton.isEnabled = false
                } else {
                    self?.fetchDataButton.isEnabled = true
                }
            }
            .store(in: &cancellables)
        
        self.viewModel.$error
            .receive(on: DispatchQueue.main)
            .sink { [weak self] error in
                guard let self = self else {
                    return
                }
                
                if let error = error {
                    self.label.isHidden = false
                    self.label.text = "Error: \(error)"
                } else {
                    self.label.isHidden = true
                }
            }
            .store(in: &cancellables)
    }
    
    private func setupTableView() {
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.tableView.dataSource = self
    }
}

//IBAction
extension Issue15MainViewController {
    @IBAction private func didTapFetchDataButton(_ sender: Any) {
        if let id = textField.text {
            if id.isEmpty {
                self.viewModel.fetchData()
            } else {
                self.viewModel.getUserById(id: id)
            }
        }
    }
}

extension Issue15MainViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) 
        let user = users[indexPath.row]
        cell.textLabel?.text = user.name
        return cell
    }
}
