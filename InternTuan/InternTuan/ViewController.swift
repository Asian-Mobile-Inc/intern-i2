//
//  ViewController.swift
//  InternTuan
//
//  Created by TO on 12/09/2025.
//

import UIKit

class ViewController: UIViewController {

    private var check = -1
    private var path = UIBezierPath()
    private var firstLocation = CGPoint.zero
    private var shapeLayers: [CAShapeLayer] = [CAShapeLayer()]
    
    @IBOutlet private var labelCollections: [UILabel]!
    @IBOutlet private weak var titleLabel: UILabel!

    private var redView = UIView(frame: CGRect(x: 200, y: 200, width: 100, height: 100))
    private var blueView = UIView(frame: CGRect(x: 200, y: 350, width: 100, height: 100))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
    
    private func setupUI() {
        self.redView.backgroundColor = .red
        self.view.addSubview(redView)
        
        self.blueView.backgroundColor = .blue
        self.view.addSubview(blueView)
        
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
    
//MARK: Issue 2
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            if touch.view == redView {
                let location = touch.location(in: self.view)
                self.redView.center = location
            } else if touch.view == blueView {
                let location = touch.location(in: self.view)
                self.blueView.center = location
            } else {
                let location = touch.location(in: self.view)
                
                path.removeAllPoints()
                path.move(to: firstLocation)
                path.addLine(to: location)
                if let shapeLayer = self.shapeLayers.last {
                    self.view.layer.addSublayer(shapeLayer)
                    shapeLayer.lineWidth = 2
                    shapeLayer.strokeColor = UIColor.blue.cgColor
                    shapeLayer.path = path.cgPath
                }
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            if touch.view == redView {
                debugPrint("inside red view")
            } else if touch.view == blueView {
                debugPrint("inside blue view")
            } else {
                let location = touch.location(in: self.view)
                self.firstLocation = location
            }
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        debugPrint("touch canceled")
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.shapeLayers.append(CAShapeLayer())
    }
    
    @objc private func tap() {
        self.updateLabelCollections()
        debugPrint("did tap anh Thanh \(check)")
    }
    
    @IBAction private func tapResetButton(_ sender: Any) {
        self.resetShapeLayer()
        self.check = -1
        self.updateLabelCollections()
    }
    
    private func resetShapeLayer() {
        self.shapeLayers.forEach({ shapeLayer in
            shapeLayer.removeFromSuperlayer()
        })
        self.shapeLayers.removeAll()
        self.shapeLayers.append(CAShapeLayer())
    }
    
    private func updateLabelCollections() {
        self.check += 1
        self.labelCollections.forEach({ label in
            label.text = "\(check)"
        })
    }
}

