//
//  RectangulerView2.swift
//  InternTuan
//
//  Created by TO on 18/09/2025.
//

import Foundation
import UIKit

class RectangularView2: UIView {

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
        
        let r3 = r / 2
        
        let gPath1 = UIBezierPath(arcCenter: CGPoint(x: width - a, y: a),
                                    radius: r3,
                                    startAngle: 1.57,
                                    endAngle: 3.14,
                                    clockwise: true)
//        UIColor.red.setStroke()
//        pathTemp.stroke()
        UIColor.white.setFill()
        gPath1.fill()
        
        let gPath11 = UIBezierPath()
        gPath11.move(to: CGPoint(x: width / 2, y: a))
        gPath11.addLine(to: CGPoint(x: width - a, y: height / 2))
        UIColor.white.setStroke()
        gPath11.stroke()
        gPath11.close()
        
        let gPath2 = UIBezierPath(arcCenter: CGPoint(x: a, y: a),
                                    radius: r3,
                                    startAngle: 1.57 - 1.57,
                                    endAngle: 3.14 - 1.57,
                                    clockwise: true)
//        UIColor.red.setStroke()
//        gPath2.stroke()
        UIColor.white.setFill()
        gPath2.fill()
        gPath2.close()
        
        let gPath21 = UIBezierPath()
        gPath21.move(to: CGPoint(x: width / 2,
                                 y: a))
        gPath21.addLine(to: CGPoint(x: a,
                                    y: height / 2))
        UIColor.white.setStroke()
        gPath21.stroke()
        gPath21.close()
        
        let gPath3 = UIBezierPath(arcCenter: CGPoint(x: width - a, y: height - a),
                                    radius: r3,
                                  startAngle: 1.57 - 1.57 + 3.14,
                                  endAngle: 3.14 - 1.57 + 3.14,
                                    clockwise: true)
//        UIColor.red.setStroke()
//        gPath2.stroke()
        UIColor.white.setFill()
        gPath3.fill()
        gPath3.close()
        
        let gPath31 = UIBezierPath()
        gPath31.move(to: CGPoint(x: width / 2,
                                 y: a))
        gPath31.addLine(to: CGPoint(x: a,
                                    y: height / 2))
        UIColor.white.setStroke()
        gPath31.stroke()
        gPath31.close()
        
        let gPath4 = UIBezierPath(arcCenter: CGPoint(x: a, y: height - a),
                                    radius: r3,
                                  startAngle: 1.57 + 3.14,
                                  endAngle: 3.14 + 3.14,
                                    clockwise: true)
//        UIColor.red.setStroke()
//        pathTemp.stroke()
        UIColor.white.setFill()
        gPath4.fill()
        
        let gPath41 = UIBezierPath()
        gPath41.move(to: CGPoint(x: width / 2, y: a))
        gPath41.addLine(to: CGPoint(x: width - a, y: height / 2))
        UIColor.white.setStroke()
        gPath41.stroke()
        gPath41.close()
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
