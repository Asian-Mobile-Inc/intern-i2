//
//  ARCustomTabBar.swift
//  InternTuan
//
//  Created by Tuan on 10/2/26.
//

import UIKit

class ARCustomTabBar: UIView {

    weak var delegate: TabBarViewDelegate?
    
    @IBOutlet weak var backgroundView: UIView!
    
    
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setupUI() {
        self.backgroundView.backgroundColor = .white
        self.backgroundView.layer.cornerRadius = 16
        self.backgroundView.layer.shadowColor = UIColor.black.cgColor
        self.backgroundView.layer.shadowOffset = CGSize(width: 0, height: -2)
        self.backgroundView.layer.shadowRadius = 16
        self.backgroundView.layer.shadowOpacity = 0.36
    }
    
    func updateUI(selectedTab: Tab) {
        switch selectedTab {
            
        default:
            break
        }
    }
    
    @IBAction func tapHome(_ sender: Any) {
        delegate?.tabBarView(self, didSelect: .home)
    }
    
    @IBAction func tapLesson(_ sender: Any) {
        delegate?.tabBarView(self, didSelect: .profile)
    }
    
    @IBAction func tapMyArt(_ sender: Any) {
        delegate?.tabBarView(self, didSelect: .fourth)
    }
    
    @IBAction func tapSetting(_ sender: Any) {
        delegate?.tabBarView(self, didSelect: .fifth)
    }
}
