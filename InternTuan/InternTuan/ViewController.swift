//
//  ViewController.swift
//  InternTuan
//
//  Created by TO on 12/09/2025.
//

import UIKit

class ViewController: UIViewController {

    var check = -1
    
    @IBOutlet private var labelCollections: [UILabel]!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var centerButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
    
    private func setupUI() {
//avatar
        let avartarFrame = CGRect(x: 50, y: 100, width: 100, height: 100)
        let userAvatar = UIImageView(image: UIImage(named: "anhThanh"))
        userAvatar.frame = avartarFrame
        userAvatar.contentMode = . scaleToFill
        self.view.addSubview(userAvatar)
//label
        let labelFrame = CGRect(x: 50, y: 200, width: 100, height: 30)
        let nameLabel = UILabel(frame: labelFrame)
        nameLabel.text = "Anh Thanh"
        nameLabel.textAlignment = .center
        nameLabel.backgroundColor = .lightGray
        self.view.addSubview(nameLabel)
        
//button
        let buttonFrame = CGRect(x: 50, y: 100, width: 100, height: 130)
        let tapButton = UIButton(frame: buttonFrame)
        tapButton.backgroundColor = .clear
        tapButton.addTarget(self, action: #selector(tap), for: .touchUpInside)
        self.view.addSubview(tapButton)
        
//IBOutlet
        self.titleLabel.text = "Title Label"
        self.updateLabelCollections()
    }
    
    @objc private func tap() {
        self.updateLabelCollections()
        debugPrint("did tap anh Thanh \(check)")
    }
    
    @IBAction private func tapCenterButton(_ sender: Any) {
        self.check = -1
        self.updateLabelCollections()
    }
    
    private func updateLabelCollections() {
        self.check += 1
        self.labelCollections.forEach({ label in
            label.text = "\(check)"
        })
    }
}

