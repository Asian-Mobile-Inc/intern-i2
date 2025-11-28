//
//  Issue15MainViewController.swift
//  InternTuan
//
//  Created by Nguên Bản on 28/11/25.
//

import UIKit
import Combine

class Issue15MainViewController: UIViewController {

    private var songs: [Song] = []
    private let viewModel = Issue15MainViewModel()
    private var cancellables = Set<AnyCancellable>()
    
    @IBOutlet private weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViewModel()
        self.setupTableView()
    }

    static func instantiate() -> Issue15MainViewController {
        return Issue15MainViewController(nibName: StringConstants.viewController.issue15MainVC, bundle: nil)
    }
}

//MARK: setup
extension Issue15MainViewController {
    private func setupViewModel() {
        self.viewModel.$songs
            .receive(on: DispatchQueue.main)
            .sink { [weak self] songs in
                guard let self = self else { return }
                self.songs = songs
                debugPrint("did update songs count: \(songs.count)")
                self.tableView.reloadData()
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
        self.viewModel.fetchData()
    }
}

extension Issue15MainViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! UITableViewCell
        let song = songs[indexPath.row]
        cell.textLabel?.text = song.title
        return cell
    }
}
