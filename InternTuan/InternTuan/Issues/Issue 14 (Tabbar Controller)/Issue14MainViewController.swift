//
//  Issue14MainViewController.swift
//  InternTuan
//
//  Created by Nguên Bản on 24/11/25.
//

import UIKit

class Issue14MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    static func instantiate() -> Issue14MainViewController {
        return Issue14MainViewController(nibName: StringConstants.viewController.issue14MainVC, bundle: nil)
    }

}

//IBAction
extension Issue14MainViewController {
    @IBAction private func tapDefault() {
        let vc = Issue14DefaultTabbarController.instantiate()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
