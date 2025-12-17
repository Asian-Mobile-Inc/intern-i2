//
//  MarkupShapeItem.swift
//  InternTuan
//
//  Created by Nguên Bản on 9/12/25.
//

import UIKit

class MarkupShapeItem: UIView {

    enum ShapeType { case rect, oval }
    let type: ShapeType

    init(type: ShapeType = .rect) {
        self.type = type
        super.init(frame: CGRect(x: 80, y: 180, width: 120, height: 80))
        backgroundColor = .clear
    }

    required init?(coder: NSCoder) { fatalError() }

    override func draw(_ rect: CGRect) {
        let path: UIBezierPath = (type == .rect)
            ? UIBezierPath(rect: rect.insetBy(dx: 3, dy: 3))
            : UIBezierPath(ovalIn: rect.insetBy(dx: 3, dy: 3))

        UIColor.black.setStroke()
        path.lineWidth = 3
        path.stroke()
    }
}
