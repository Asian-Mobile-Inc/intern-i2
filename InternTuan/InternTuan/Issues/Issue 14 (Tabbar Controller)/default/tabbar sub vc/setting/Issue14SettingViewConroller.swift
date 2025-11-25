//
//  Issue14SettingViewConroller.swift
//  InternTuan
//
//  Created by Nguên Bản on 24/11/25.
//

import UIKit

class Issue14SettingViewConroller: UIViewController {

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

    static func instantiate() -> Issue14SettingViewConroller {
        return Issue14SettingViewConroller(nibName: StringConstants.viewController.issue14SettingVC, bundle: nil)
    }
    
}
