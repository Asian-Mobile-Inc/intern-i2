//
//  MarkupTextItem.swift
//  InternTuan
//
//  Created by Nguên Bản on 9/12/25.
//

import UIKit

class MarkupTextItem: UITextView {
    init() {
        super.init(frame: CGRect(x: 40, y: 100, width: 160, height: 40), textContainer: nil)
        backgroundColor = .clear
        font = .systemFont(ofSize: 20)
        isScrollEnabled = false
        text = "Text"
    }

    required init?(coder: NSCoder) { fatalError() }
}
