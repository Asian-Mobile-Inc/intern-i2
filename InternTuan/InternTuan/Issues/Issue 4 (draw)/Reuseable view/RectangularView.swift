//
//  RectangularView.swift
//  InternTuan
//
//  Created by TO on 16/09/2025.
//

import Foundation
import UIKit

class RectangularView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        let path = createCircle()
        
        UIColor.lightGray.setFill()
        UIColor.red.setStroke()
        path.lineWidth = 1
        path.fill()
        path.stroke()
    }
    
    func createPath() -> UIBezierPath {
//        let path = UIBezierPath()
//        path.move(to: CGPoint(x: 0, y: 0))
//        path.addLine(to: CGPoint(x: self.frame.size.width,
//                                 y: self.frame.size.height))
//        return path
        return UIBezierPath(roundedRect: self.bounds, cornerRadius: 15.0)
    }
    
    func createTriangle() -> UIBezierPath{
        let path = UIBezierPath()
        path.move(to: CGPoint(x: self.frame.width/2, y: 0.0))
        path.addLine(to: CGPoint(x: 0.0, y: self.frame.size.height))
        path.addLine(to: CGPoint(x: self.frame.size.width, y: self.frame.size.height))
        path.close()
        
        return path
    }
    
    func createOval() -> UIBezierPath {
        return UIBezierPath(ovalIn: self.bounds)
    }
    
    func createCircle() -> UIBezierPath {
        let r = self.frame.size.height < self.frame.size.width ? self.frame.size.height : self.frame.size.width
        return UIBezierPath(ovalIn: CGRect(x: self.frame.size.width == r ? 0 : self.frame.size.width / 2 - r / 2,
                                           y: self.frame.size.height == r ? 0 : self.frame.size.height / 2 - r / 2,
                                           width: r,
                                           height: r))
    }
    
    func createCustomRadiusShape() -> UIBezierPath {
        return UIBezierPath(roundedRect: self.bounds,
                            byRoundingCorners: [.topLeft, .bottomRight],
                            cornerRadii: CGSize(width: 100.0, height: 10.0))
    }
    
    func createHalfCircle() -> UIBezierPath {
        return UIBezierPath(arcCenter: CGPoint(x: self.frame.size.width/2, y: self.frame.size.height/2),
                            radius: self.frame.size.height/2,
                            startAngle: 3.14,
                            endAngle: 6.28,
                            clockwise: true)
    }
}
