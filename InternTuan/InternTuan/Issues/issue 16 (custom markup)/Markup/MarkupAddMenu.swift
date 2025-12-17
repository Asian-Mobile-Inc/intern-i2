//
//  MarkupAddMenu.swift
//  InternTuan
//
//  Created by Nguên Bản on 9/12/25.
//

import UIKit

class MarkupAddMenu: UIView {

    var onAddText: (() -> Void)?
    var onAddSignature: (() -> Void)?
    var onAddShape: (() -> Void)?

    private let stack = UIStackView()

    init() {
        super.init(frame: .zero)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }

    private func setupUI() {
        backgroundColor = .white
        layer.cornerRadius = 12
        layer.shadowOpacity = 0.15
        layer.shadowRadius = 8

        stack.axis = .vertical
        stack.distribution = .fillEqually

        let btn1 = createButton("Add text", icon: "textformat") { self.onAddText?() }
        let btn2 = createButton("Add signature", icon: "signature") { self.onAddSignature?() }
        let btn3 = createButton("Add shape", icon: "square.on.circle") { self.onAddShape?() }

        stack.addArrangedSubview(btn1)
        stack.addArrangedSubview(btn2)
        stack.addArrangedSubview(btn3)

        addSubview(stack)
        stack.pinToEdges(of: self, inset: 8)
    }

    private func createButton(_ title: String, icon: String, action: @escaping () -> Void) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.setImage(UIImage(systemName: icon), for: .normal)
        button.tintColor = .black

        button.contentHorizontalAlignment = .leading
        button.addAction(UIAction { _ in action() }, for: .touchUpInside)

        return button
    }

    func show(at source: UIView, in container: UIView) {
        frame = CGRect(x: source.frame.minX - 150 + 40,
                       y: source.frame.minY - 140,
                       width: 150,
                       height: 130)
        container.addSubview(self)
    }
}
