//
//  MyImageTitleView.swift
//  InternTuan
//
//  Created by TO on 15/09/2025.
//

import Foundation
import UIKit

class MyImageTitleView: UIView {
    
    private var count = 0
    
    var avatar: UIImageView?
    var label: UILabel?
    var button: UIButton?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .blue
        
        avatar = UIImageView(image: UIImage(named: "anhThanh"))
        if let avatar = avatar {
            avatar.frame = CGRect(x: 0,
                                  y: 0,
                                  width: Int(self.frame.size.width),
                                  height: Int(self.frame.size.height * 4 / 5))
            avatar.contentMode = .scaleToFill
            self.addSubview(avatar)
        }
        
        label = UILabel(frame: CGRect(x: 0,
                                          y: Int(self.frame.size.height * 4 / 5),
                                          width: Int(self.frame.size.width),
                                          height: Int(self.frame.size.height / 5)))
        if let label = label {
            label.text = "anh Thanh"
            label.backgroundColor = .lightGray
            label.textColor = .red
            label.textAlignment = .center
            self.addSubview(label)
        }
        
        if var button = button {
            button = UIButton(frame: CGRect(x: 0,
                                            y: 0,
                                            width: Int(self.frame.size.width),
                                            height: Int(self.frame.size.height)))
            button.backgroundColor = .clear
            button.addTarget(self, action: #selector(numCount), for: .touchUpInside)
            self.addSubview(button)
        }
    }
    
    @objc func numCount() {
        self.count += 1
        self.label?.text = "\(count)"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
