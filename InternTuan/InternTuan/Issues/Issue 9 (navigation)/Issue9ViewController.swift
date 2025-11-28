//
//  Issue9ViewController.swift
//  InternTuan
//
//  Created by Nguên Bản on 10/10/25.
//

import UIKit

class Issue9ViewController: UIViewController {

//    private let searchController = UISearchController(searchResultsController: Issue9PushViewController.instantiate())
    private let searchController = UISearchController(searchResultsController: nil)
    private var hideNavigationBar: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Issue 9"
        definesPresentationContext = true
        self.setupNavBar()
    }

    override func viewDidAppear(_ animated: Bool) {
        debugPrint("search bar is active: \(searchController.isActive)")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        debugPrint("view did disappear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        searchController.isActive = false
        view.endEditing(true)
        navigationController?.isToolbarHidden = true
    }
    
    static func instantiate() -> Issue9ViewController {
        return Issue9ViewController(nibName: "Issue9ViewController", bundle: nil)
    }
    
    private func setupNavBar() {
        let appearance = UINavigationBarAppearance()
        
        appearance.titleTextAttributes = [.foregroundColor: UIColor.black]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.black]
        appearance.shadowColor = nil
        
        let navBar = navigationController?.navigationBar
        navBar?.standardAppearance = appearance
        navBar?.scrollEdgeAppearance = appearance
        navBar?.compactAppearance = appearance
        navBar?.tintColor = .black
        
        // (1) Tạo search controller
        searchController.searchBar.placeholder = "Tìm kiếm"
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchResultsUpdater = self
        
//        2 cái này tương tự nhau, cái dưới cho iOS cũ và đã được cái trên thay thế ở các bản iOS mới
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = false
        
//        có ẩn nav bar khi dùng search bar không
        searchController.hidesNavigationBarDuringPresentation = false
        
//        có hiện nút cancell khi dùng search bar không
        searchController.automaticallyShowsCancelButton = true
        
        searchController.showsSearchResultsController = true
        
        // (2) Gắn vào navigation item
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = true
        
//        MARK: tool bar
        navigationController?.isToolbarHidden = false
        
        navigationItem.backBarButtonItem = UIBarButtonItem(
                title: "what's up?",
                style: .plain,
                target: nil,
                action: nil
            )
        
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.hidesBarsOnTap = false
    }
    @IBAction private func tapIsActiveButton(_ sender: Any) {
        debugPrint("search bar is active: \(searchController.isActive)")
    }
    
//    hide nav bar thủ công
    @IBAction private func tapHideNavBar(_ sender: Any) {
        self.hideNavigationBar.toggle()
        self.navigationController?.setNavigationBarHidden(hideNavigationBar, animated: true)
    }
    
    @IBAction private func tapPushButton(_ sender: Any) {
//        navigationItem.backButtonTitle = "what's up?"
        let vc = Issue9PushViewController.instantiate()
        self.navigationController?.pushViewController(vc, animated: true)
        let stack = navigationController?.viewControllers
        
    }
    
    @IBAction private func tapAccessibilityButon(_ sender: Any) {
//        navigationItem.backButtonTitle = "what's up?"
        let vc = Issue9AccessibilityTestViewController.instantiate()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension Issue9ViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if let text = searchController.searchBar.text {
            debugPrint("text: \(text)")
//            debugPrint("searchResultsController: \(searchController.searchResultsController)")
            debugPrint("search bar is active: \(searchController.isActive)")
        }
    }
}

extension Issue9ViewController: UISearchBarDelegate {
    
}

