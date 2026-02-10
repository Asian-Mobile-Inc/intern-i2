//
//  FirstViewController.swift
//  InternTuan
//
//  Created by Tuan on 9/2/26.
//

import UIKit

class FirstViewController: UIViewController {

    @IBOutlet weak var colorView: UIView!
    weak var tabBarDelegate: CustomTabBarDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    init(tabBarDelegate: CustomTabBarDelegate? = nil) {
        self.tabBarDelegate = tabBarDelegate
        super.init(nibName: "FirstViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarDelegate?.setTabBarHidden(shouldHide: false, animation: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        debugPrint("appear")
    }
    
    static func instantiate(tabBarDelegate: CustomTabBarDelegate? = nil) -> FirstViewController {
        return FirstViewController(tabBarDelegate: tabBarDelegate)
    }
    
    @IBAction func push(_ sender: Any) {
        let vc = Issue6ViewController.instantiate()
        self.tabBarDelegate?.pushViewController(vc, animated: true)
    }
    
    @IBAction func present(_ sender: Any) {
//        self.colorView.backgroundColor = UIColor.random
        let vc = Issue6ViewController.instantiate()
        self.tabBarDelegate?.setTabBarHidden(shouldHide: true, animation: true)
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
