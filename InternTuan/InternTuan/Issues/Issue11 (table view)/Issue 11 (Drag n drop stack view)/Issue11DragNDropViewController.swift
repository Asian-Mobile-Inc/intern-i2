//
//  Issue11DragNDropViewController.swift
//  InternTuan
//
//  Created by Nguên Bản on 6/11/25.
//

import UIKit
import OSLog

final class Issue11DragNDropViewController: UIViewController {

    let logger = Logger()
    var draggedView: UIView?
    
    @IBOutlet private weak var stackView: UIStackView!
    @IBOutlet private weak var purpleView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupSubView()
        self.setupStackView()
    }
    
    static func instantiate() -> Issue11DragNDropViewController {
        return Issue11DragNDropViewController(nibName: StringConstants.viewController.issue11DragnDropVC, bundle: nil)
    }
}

//MARK: setup
extension Issue11DragNDropViewController {
    private func setupSubView() {
        for view in self.stackView.arrangedSubviews {
            let drag = UIDragInteraction(delegate: self)
            view.addInteraction(drag)
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        let drag = UIDragInteraction(delegate: self)
        self.purpleView.addInteraction(drag)
    }
    
    private func setupStackView() {
        let drop = UIDropInteraction(delegate: self)
        self.stackView.addInteraction(drop)
    }
}

//MARK: drag interaction delegate
extension Issue11DragNDropViewController: UIDragInteractionDelegate {
    func dragInteraction(_ interaction: UIDragInteraction, itemsForBeginning session: any UIDragSession) -> [UIDragItem] {
        guard let dragged = interaction.view else {
            return []
        }
        
        self.draggedView = dragged
        
        let provider = NSItemProvider(object: NSString(string: dragged.accessibilityIdentifier ?? "item"))
        let dragItem = UIDragItem(itemProvider: provider)
        dragItem.localObject = dragged
        
        return [dragItem]
    }
    
    func dragInteraction(_ interaction: UIDragInteraction, previewForLifting item: UIDragItem, session: any UIDragSession) -> UITargetedDragPreview? {
        guard let view = interaction.view else {
            return nil
        }
//        view.alpha = 1
        let params = UIPreviewParameters()
        params.visiblePath = UIBezierPath(roundedRect: view.bounds, cornerRadius: 30)
        let center = CGPoint(x: view.bounds.midX, y: view.bounds.midY)
        let target = UIDragPreviewTarget(container: view.superview!, center: view.convert(center, to: view.superview))
        
        return UITargetedDragPreview(view: view, parameters: params, target: target)
    }
}

//MARK: drop interaction delegate
extension Issue11DragNDropViewController: UIDropInteractionDelegate {
    func dropInteraction(_ interaction: UIDropInteraction, canHandle session: any UIDropSession) -> Bool {
        let items = session.items.compactMap(
            {
                $0.localObject as? UIView
            }
        )
        
        let allAreInViews = items.allSatisfy {
            self.stackView.arrangedSubviews.contains($0)
        }
        
//        logger.debug("in view: \(allAreInViews)")
        
        return allAreInViews
    }
    
    func dropInteraction(_ interaction: UIDropInteraction, sessionDidEnter session: any UIDropSession) {
        guard let stackView = interaction.view as? UIStackView else {
            return
        }
        
        guard let dragItem = session.items.first?.localObject as? UIView else {
            return
        }
        
        stackView.layer.borderColor = dragItem.backgroundColor?.cgColor
        stackView.layer.borderWidth = 2
    }
    
    func dropInteraction(_ interaction: UIDropInteraction, sessionDidUpdate session: any UIDropSession) -> UIDropProposal {
        if session.localDragSession != nil {
            return UIDropProposal(operation: .move)
        } else {
            return UIDropProposal(operation: .copy)
        }
    }
    
    func dropInteraction(_ interaction: UIDropInteraction, performDrop session: any UIDropSession) {
        guard let stackView = interaction.view as? UIStackView else {
            return
        }
        
        let locationInStack = session.location(in: stackView)
        
        var insertIndex = stackView.arrangedSubviews.count
        
        for (index, subView) in stackView.arrangedSubviews.enumerated() {
//            logger.debug("Subview \(index): minY=\(subView.frame.minY), midY=\(subView.frame.midY)")
            if (locationInStack.y < subView.frame.minY) {
                insertIndex = index
                break
            }
        }
        
//        logger.debug("ínsert index: \(insertIndex)")
        
        for dragItem in session.items {
            if let view = dragItem.localObject as? UIView {
                if let oldIndex = stackView.arrangedSubviews.firstIndex(of: view) {
                    if (oldIndex < insertIndex) {
                        insertIndex -= 1
                    }
//                    logger.debug("ínsert index: \(insertIndex)")
//                    logger.debug("stack view arranged subviews: \(stackView.arrangedSubviews.count)")
                    stackView.removeArrangedSubview(view)
                    view.removeFromSuperview()
//                    logger.debug("ínsert index: \(insertIndex)")
//                    logger.debug("stack view arranged subviews: \(stackView.arrangedSubviews.count)")
                    if (insertIndex > stackView.arrangedSubviews.count) {
                        logger.debug("add")
                        stackView.addArrangedSubview(view)
                    } else {
                        logger.debug("insert: \(insertIndex)")
                        stackView.insertArrangedSubview(view, at: insertIndex)
                    }
                }
            }
        }
        
        logger.debug("stack view arranged subviews: \(stackView.arrangedSubviews.count)")
        
        UIView.animate(withDuration: 0.25) {
           stackView.layoutIfNeeded()
       }
    }
    
    func dropInteraction(_ interaction: UIDropInteraction, sessionDidEnd session: any UIDropSession) {
        guard let stackView = interaction.view as? UIStackView else {
            return
        }
        
        stackView.layer.borderColor = UIColor.clear.cgColor
        stackView.layer.borderWidth = 0
    }
}
