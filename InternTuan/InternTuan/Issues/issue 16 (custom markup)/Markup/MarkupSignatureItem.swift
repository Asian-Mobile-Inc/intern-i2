//
//  MarkupSignatureItem.swift
//  InternTuan
//
//  Created by Nguên Bản on 9/12/25.
//

import UIKit
import PencilKit

class MarkupSignatureItem: UIView {
    private let canvas = PKCanvasView()

    init() {
        super.init(frame: CGRect(x: 40, y: 260, width: 240, height: 120))
        layer.borderWidth = 2
        layer.borderColor = UIColor.gray.cgColor
        setupCanvas()
    }

    required init?(coder: NSCoder) { fatalError() }

    private func setupCanvas() {
        addSubview(canvas)
        canvas.pinToEdges(of: self)
        canvas.backgroundColor = .white
        canvas.drawingPolicy = .anyInput
    }
}
