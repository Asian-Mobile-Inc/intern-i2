//
//  MarkupEditorView.swift
//  InternTuan
//
//  Created by Nguên Bản on 9/12/25.
//

import UIKit
import PencilKit

public class MarkupEditorView: UIView {

    // MARK: - Public
    public let canvas = PKCanvasView()

    // MARK: - Private
    private let addButton = UIButton(type: .custom)
    private let menu = MarkupAddMenu()
    private var toolPicker: PKToolPicker?

    // MARK: - Init
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupCanvas()
        setupToolPicker()
        setupAddButton()
        setupMenuCallbacks()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupCanvas()
        setupToolPicker()
        setupAddButton()
        setupMenuCallbacks()
    }

    // MARK: - Canvas Setup
    private func setupCanvas() {
        addSubview(canvas)
        canvas.pinToEdges(of: self)
        canvas.backgroundColor = .white
        canvas.drawingPolicy = .anyInput
        canvas.becomeFirstResponder()
    }

    // MARK: - PencilKit ToolPicker Setup
    private func setupToolPicker() {
        let picker = PKToolPicker()
        toolPicker = picker
        picker.setVisible(true, forFirstResponder: canvas)
        picker.addObserver(self)
        canvas.becomeFirstResponder()
    }

    // MARK: - Plus Button Setup (giống 100% Notes)
    private func setupAddButton() {
        addSubview(addButton)

        // Kích thước giống Notes
        addButton.frame = CGRect(x: 0, y: 0, width: 42, height: 42)
        addButton.layer.cornerRadius = 21
        addButton.backgroundColor = UIColor(white: 0.95, alpha: 1)
        addButton.setImage(UIImage(systemName: "plus"), for: .normal)

        addButton.addTarget(self, action: #selector(showMenu), for: .touchUpInside)

        bringSubviewToFront(addButton)
    }

    // MARK: - Position button bên phải ToolPicker
    private func updateAddButtonPosition() {
        guard let picker = toolPicker else { return }
        guard let window = self.window else { return }
        let pickerFrameInWindow = picker.frameObscured(in: window)

        // Convert frame ToolPicker về hệ toạ độ của view
        let frame = convert(pickerFrameInWindow, from: nil)

        // Notes đặt nút + bên phải 10px
        let plusX = frame.maxX + 10
        let plusY = frame.midY - 21 // canh giữa

        addButton.frame.origin = CGPoint(x: plusX, y: plusY)
        bringSubviewToFront(addButton)
    }

    public override func layoutSubviews() {
        super.layoutSubviews()
        updateAddButtonPosition()
    }

    // MARK: - Menu callbacks
    private func setupMenuCallbacks() {
        menu.onAddText = { [weak self] in self?.addTextItem() }
        menu.onAddSignature = { [weak self] in self?.addSignatureItem() }
        menu.onAddShape = { [weak self] in self?.addShapeItem() }
    }

    @objc private func showMenu() {
        menu.show(at: addButton, in: self)
    }

    // MARK: - Add Items
    private func addTextItem() {
        let text = MarkupTextItem()
        addSubview(text)
        bringSubviewToFront(addButton)
    }

    private func addSignatureItem() {
        let sign = MarkupSignatureItem()
        addSubview(sign)
        bringSubviewToFront(addButton)
    }

    private func addShapeItem() {
        let shape = MarkupShapeItem(type: .rect)
        addSubview(shape)
        bringSubviewToFront(addButton)
    }
}

// MARK: - ToolPicker Observer
extension MarkupEditorView: PKToolPickerObserver {
    public func toolPickerFramesDidChange(_ toolPicker: PKToolPicker) {
        updateAddButtonPosition()
    }
}
