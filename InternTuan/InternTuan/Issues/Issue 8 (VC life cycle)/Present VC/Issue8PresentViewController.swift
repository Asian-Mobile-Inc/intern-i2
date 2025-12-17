//
//  Issue8PresentViewController.swift
//  InternTuan
//
//  Created by Nguên Bản on 1/10/25.
//

import UIKit

extension UIImage {
    static func gradientImage(bounds: CGRect, colors: [UIColor]) -> UIImage {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = colors.map(\.cgColor)

        // This makes it left to right, default is top to bottom
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)

        let renderer = UIGraphicsImageRenderer(bounds: bounds)

        return renderer.image { ctx in
            gradientLayer.render(in: ctx.cgContext)
        }
    }
}

class Issue8PresentViewController: UIViewController {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var bigView: UIView!
    @IBOutlet weak var smallView: UIView!
    @IBOutlet weak var animateView: UIView!
    
    private var smallState: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        debugPrint("Issue 8 Present VC did load")
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        animateView.isUserInteractionEnabled = true
        animateView.addGestureRecognizer(tap)


    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let gradient = UIImage.gradientImage(bounds: label.bounds, colors: [.systemBlue, .systemRed])
        label.textColor = UIColor(patternImage: gradient)
        
        
        let borderGradient = UIImage.gradientImage(bounds: animateView.bounds, colors: [.systemBlue, .systemRed])
        self.animateView.layer.borderColor = UIColor(patternImage: borderGradient).cgColor
        self.animateView.layer.borderWidth = 3
        self.animateView.layer.cornerRadius = 12
//        self.animateView.backgroundColor = UIColor(patternImage: borderGradient)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.animateView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    @objc func handleTap() {
        UIView.animate(withDuration: 0.2, animations: { [weak self] in
            guard let self = self else {
                return
            }
            
            if smallState {
                self.animateView.frame = self.bigView.frame
                smallState.toggle()
            } else {
                self.animateView.frame = self.smallView.frame
                smallState.toggle()
            }
        })
        
        loadViewIfNeeded()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if isMovingFromParent {
            debugPrint("pop")
        } else if isBeingDismissed {
            debugPrint("dismiss")
        }
        debugPrint("Issue 8 Present VC did disappear")
    }
    
    @IBAction private func tapDismiss(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    static func instantiate() -> Issue8PresentViewController {
        return Issue8PresentViewController(nibName: "Issue8PresentViewController", bundle: nil)
    }

}
