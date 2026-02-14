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
    @IBOutlet weak var homeIcon: UIImageView!
    @IBOutlet weak var lessonIcon: UIImageView!
    @IBOutlet weak var myArtIcon: UIImageView!
    @IBOutlet weak var settingIcon: UIImageView!
    @IBOutlet var tabBarIcons: [UIImageView]!
    @IBOutlet weak var homeLabel: UILabel!
    @IBOutlet weak var lessonLabel: UILabel!
    @IBOutlet weak var myArtLabel: UILabel!
    @IBOutlet weak var settingLabel: UILabel!
    @IBOutlet var tabBarLabels: [UILabel]!
    
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
        tabBarIcons.forEach({ tab in
            tab.isHighlighted = false
        })
        
        tabBarLabels.forEach({label in
            label.textColor = .black
        })
        
        let bounceAnimation = CAKeyframeAnimation(keyPath: "transform.scale")
//        bounceAnimation.values = [1.0, 0.85, 1.02, 0.95, 1.02, 1.0]
        bounceAnimation.values = [1.0, 0.85, 1.02, 0.95, 1.0]
        bounceAnimation.duration = 0.3
        bounceAnimation.calculationMode = .cubic
        
        switch selectedTab {
        case .home:
            self.homeIcon.isHighlighted = true
            homeIcon.layer.add(bounceAnimation, forKey: "bounceAnimation")
            self.homeLabel.textColor = UIColor(resource: .color)
            break
        case .profile:
            self.lessonIcon.isHighlighted = true
            lessonIcon.layer.add(bounceAnimation, forKey: "bounceAnimation")
            self.lessonLabel.textColor = UIColor(resource: .color)
            break
        case .fourth:
            self.myArtIcon.isHighlighted = true
            myArtIcon.layer.add(bounceAnimation, forKey: "bounceAnimation")
            self.myArtLabel.textColor = UIColor(resource: .color)
            break
        case .fifth:
            self.settingIcon.isHighlighted = true
            settingIcon.layer.add(bounceAnimation, forKey: "bounceAnimation")
            self.settingLabel.textColor = UIColor(resource: .color)
            break
        default:
            break
        }
    }
    
    func unHighlightAllTabs() {
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
