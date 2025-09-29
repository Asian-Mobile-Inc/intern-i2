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
        
        let width = self.frame.size.width
        let height = self.frame.size.height
        
        UIColor.lightGray.setFill()
//        UIColor.red.setStroke()
        UIColor.clear.setStroke()
        path.lineWidth = 1
        path.fill()
        path.stroke()
        path.close()
        
        let a = width / 12
        
        let r = height - a * 2
        
        let path1 = UIBezierPath(ovalIn: CGRect(x: a, y: a, width: r, height: r))
        UIColor.white.setFill()
        path1.fill()
//        UIColor.red.setStroke()
        path1.stroke()
        path1.close()
        
        
        
        let path2 = UIBezierPath()
        path2.move(to: CGPoint(x: width / 2, y: a))
        path2.addLine(to: CGPoint(x: width - a, y: height / 2))
        path2.addLine(to: CGPoint(x: width / 2, y: height - a))
        path2.addLine(to: CGPoint(x: a, y: height / 2))
        path2.addLine(to: CGPoint(x: width / 2, y: a))
        UIColor.lightGray.setFill()
        path2.fill()
        path2.stroke()
        path2.close()
        
        let r3 = (width / 2 - a) / 2
//MARK: green
        let path3 = UIBezierPath(arcCenter: CGPoint(x: width / 2 + r3, y: height / 2 - r3),
                                 radius: r3 + a,
                                 startAngle: 2.355 - 1.57 + 1.57,
                                 endAngle: 5.495 - 1.57,
                                 clockwise: true)
        UIColor.white.setFill()
        path3.fill()
//        UIColor.green.setStroke()
        path3.stroke()
        path3.close()

        let path31 = UIBezierPath(arcCenter: CGPoint(x: width / 2 + r3, y: height / 2 - r3),
                                 radius: r3 + a,
                                 startAngle: 2.355 - 1.57,
                                  endAngle: 5.495 - 1.57 - 1.57,
                                 clockwise: true)
        UIColor.white.setFill()
        path31.fill()
//        UIColor.green.setStroke()
        path31.stroke()
        path31.close()
//MARK: blue
        let path4 = UIBezierPath(arcCenter: CGPoint(x: width / 2 - r3, y: height / 2 + r3),
                                 radius: r3 + a,
                                 startAngle: 2.355 + 1.57 + 1.57,
                                 endAngle: 5.495 + 1.57,
                                 clockwise: true)
        UIColor.white.setFill()
        path4.fill()
//        UIColor.blue.setStroke()
        path4.stroke()
        path4.close()

        let path41 = UIBezierPath(arcCenter: CGPoint(x: width / 2 - r3, y: height / 2 + r3),
                                 radius: r3 + a,
                                 startAngle: 2.355 + 1.57,
                                  endAngle: 5.495 + 1.57 - 1.57,
                                 clockwise: true)
        UIColor.white.setFill()
        path41.fill()
//        UIColor.blue.setStroke()
        path41.stroke()
        path41.close()
//MARK: yellow
        let path5 = UIBezierPath(arcCenter: CGPoint(x: width / 2 + r3, y: height / 2 + r3),
                                 radius: r3 + a,
                                 startAngle: 2.355 + 1.57,
                                 endAngle: 5.495,
                                 clockwise: true)
        UIColor.white.setFill()
        path5.fill()
//        UIColor.yellow.setStroke()
        path5.stroke()
        path5.close()

        let path51 = UIBezierPath(arcCenter: CGPoint(x: width / 2 + r3, y: height / 2 + r3),
                                 radius: r3 + a,
                                 startAngle: 2.355,
                                  endAngle: 5.495 - 1.57,
                                 clockwise: true)
        UIColor.white.setFill()
        path51.fill()
//        UIColor.yellow.setStroke()
        path51.stroke()
        path51.close()
//MARK: red
        let path6 = UIBezierPath(arcCenter: CGPoint(x: width / 2 - r3, y: height / 2 - r3),
                                 radius: r3 + a,
                                 startAngle: 2.355 + 3.14 + 1.57,
                                 endAngle: 5.495 + 3.14,
                                 clockwise: true)
        UIColor.white.setFill()
        path6.fill()
//        UIColor.red.setStroke()
        path6.stroke()
        path6.close()

        let path61 = UIBezierPath(arcCenter: CGPoint(x: width / 2 - r3, y: height / 2 - r3),
                                 radius: r3 + a,
                                 startAngle: 2.355 + 3.14,
                                  endAngle: 5.495 + 3.14 - 1.57,
                                 clockwise: true)
        UIColor.white.setFill()
        path61.fill()
//        UIColor.red.setStroke()
        path61.stroke()
        path61.close()
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
