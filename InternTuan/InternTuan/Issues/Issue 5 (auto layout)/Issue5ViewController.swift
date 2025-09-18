//
//  Issue5ViewController.swift
//  InternTuan
//
//  Created by TO on 18/09/2025.
//

import UIKit

class Issue5ViewController: UIViewController {

    @IBOutlet private weak var topView: UIView!
    @IBOutlet private weak var middleView: UIView!
    @IBOutlet private weak var bottomView: UIView!
    @IBOutlet private weak var leftBottom2: UIView!
    @IBOutlet private weak var leftBottom1: UIView!
    @IBOutlet private weak var leftBottomMiddle: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let recetView1 = RectangularView(frame: self.topView.bounds)
        self.topView.addSubview(recetView1)
        
        let recetView2 = RectangularView(frame: self.bottomView.bounds)
        self.bottomView.addSubview(recetView2)
        
        let recetView3 = RectangularView2(frame: self.middleView.bounds)
        self.middleView.addSubview(recetView3)
        
        let rectView4 = RectangularView(frame: self.leftBottom1.bounds)
        self.leftBottom1.addSubview(rectView4)
        
        let rectView5 = RectangularView(frame: self.leftBottom2.bounds)
        self.leftBottom2.addSubview(rectView5)
        
        let rectView6 = RectangularView2(frame: self.leftBottomMiddle.bounds)
        self.leftBottomMiddle.addSubview(rectView6)
    }
    
}
