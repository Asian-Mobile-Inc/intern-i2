//
//  CustomTabbar.swift
//  InternTuan
//
//  Created by Nguên Bản on 25/11/25.
//

import UIKit

enum TabbarItem: Int {
    case home = 0
    case profile
    case setting
}

class CustomTabbar: UIView {
    
    private let itemTintColor: UIColor = UIColor.systemBlue
    private let defaultColor: UIColor = UIColor.black
    private var selectedItemIndex: Int = 0 {
        willSet {
            self.unhighLightItemAtIndex(index: self.selectedItemIndex)
        }
        didSet {
            self.highLightItemAtIndex(index: self.selectedItemIndex)
        }
    }
    
    @IBOutlet private weak var homeItemView: UIView!
    @IBOutlet private weak var homeImageView: UIImageView!
    @IBOutlet private weak var homeLabel: UILabel!
    
    @IBOutlet private weak var profileItemView: UIView!
    @IBOutlet private weak var profileImageView: UIImageView!
    @IBOutlet private weak var profileLabel: UILabel!
    
    @IBOutlet private weak var settingItemView: UIView!
    @IBOutlet private weak var settingImageView: UIImageView!
    @IBOutlet private weak var settingLabel: UILabel!
 
    @IBOutlet private weak var selectedItemBar: UIView!
    
    public func render() {
        debugPrint("did load")
        self.selectedItemBar.backgroundColor = self.itemTintColor
        self.selectedItemBar.layer.cornerRadius = 2.5
        self.selectedItemBar.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func highLightItemAtIndex(index: Int) {
        switch index {
        case 0:
            UIView.animate(withDuration: 0.2, animations: { [weak self] in
                guard let self = self else {
                    return
                }
                self.homeImageView.tintColor = itemTintColor
                self.homeLabel.textColor = itemTintColor
                let selectedItemBarFrame = CGRect(
                    x: self.homeItemView.frame.minX,
                    y: self.homeItemView.frame.minY,
                    width: self.selectedItemBar.bounds.size.width,
                    height: self.selectedItemBar.bounds.size.height)
                self.selectedItemBar.frame = selectedItemBarFrame
            })
            return
        case 1:
            UIView.animate(withDuration: 0.2, animations: { [weak self] in
                guard let self = self else {
                    return
                }
                self.profileImageView.tintColor = itemTintColor
                self.profileLabel.textColor = itemTintColor
            
                let selectedItemBarFrame = CGRect(
                    x: self.profileItemView.frame.minX,
                    y: self.profileItemView.frame.minY,
                    width: self.selectedItemBar.bounds.size.width,
                    height: self.selectedItemBar.bounds.size.height)
                self.selectedItemBar.frame = selectedItemBarFrame
            })
            return
        case 2:
            UIView.animate(withDuration: 0.2, animations: { [weak self] in
                guard let self = self else {
                    return
                }
                self.settingImageView.tintColor = itemTintColor
                self.settingLabel.textColor = itemTintColor
                let selectedItemBarFrame = CGRect(
                    x: self.settingItemView.frame.minX,
                    y: self.settingItemView.frame.minY,
                    width: self.selectedItemBar.bounds.size.width,
                    height: self.selectedItemBar.bounds.size.height)
                self.selectedItemBar.frame = selectedItemBarFrame
            })
            return
        default:
            return
        }
    }
    
    private func unhighLightItemAtIndex(index: Int) {
        switch index {
        case 0:
            self.homeImageView.tintColor = defaultColor
            self.homeLabel.textColor = defaultColor
            return
        case 1:
            self.profileImageView.tintColor = defaultColor
            self.profileLabel.textColor = defaultColor
            return
        case 2:
            self.settingImageView.tintColor = defaultColor
            self.settingLabel.textColor = defaultColor
            return
        default:
            return
        }
    }
    
    public func highLightItem(tabbarItem: TabbarItem) {
        self.selectedItemIndex = tabbarItem.rawValue
    }
    
    public func pHighLightItemAtIndex(index: Int) {
        debugPrint("did select index: \(index)")
        self.selectedItemIndex = index
    }
    
    public func frameOfItemAtIndex(index: Int) -> CGRect {
        switch index {
        case 0:
            return self.homeItemView.frame
        case 1:
            return self.profileItemView.frame
        case 2:
            return self.settingItemView.frame
        default:
            return .zero
        }
    }
}
