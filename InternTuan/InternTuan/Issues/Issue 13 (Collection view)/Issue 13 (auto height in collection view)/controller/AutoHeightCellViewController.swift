//
//  AutoHeightCellViewController.swift
//  InternTuan
//
//  Created by Nguên Bản on 20/11/25.
//

import UIKit
import OSLog

final class AutoHeightCellViewController: UIViewController {
    
    private let logger = Logger()

    private let minimumLineSpacing: CGFloat = 10
    private let minimumInteritemSpacing: CGFloat = 10
    private let numOfColums: CGFloat = 1
    
    private var selectedItemIndexPath: IndexPath?
    private var deselectedItemIndexPath: IndexPath?
    private var selectedIndexPaths: [IndexPath] = []
    private var indexPathToUpdateAtMultipleSelection: IndexPath?
    
    private var items: [Int] = []
    
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var selectModeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupItems()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.setupCollectonView()
    }

    static func instantiate() -> AutoHeightCellViewController {
        return AutoHeightCellViewController(nibName: StringConstants.viewController.autoHeightCellVC, bundle: nil)
    }
}

//MARK: setup
extension AutoHeightCellViewController {
    private func setupCollectonView() {
        let autoHeightCellNib = UINib(nibName: StringConstants.collectionViewCell.autoHeightCell, bundle: nil)
        self.collectionView.register(autoHeightCellNib, forCellWithReuseIdentifier: StringConstants.collectionViewCell.autoHeightCell)
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.dragDelegate = self
        self.collectionView.dropDelegate = self
        self.collectionView.dragInteractionEnabled = true
        
        if let layout = self.collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            self.collectionView.layoutIfNeeded()
            layout.sectionInset = .zero
            let width = Int((self.collectionView.bounds.size.width - minimumInteritemSpacing * (numOfColums - 1)) / numOfColums)
            layout.estimatedItemSize = CGSize(width: width - 20, height: 100)
            self.collectionView.collectionViewLayout = layout
        }
    }
    
    private func setupItems() {
        for _ in (1...20) {
            let randomNumber = Int.random(in: 1...3)
            self.items.append(randomNumber)
        }
    }
}

//MARK: service
extension AutoHeightCellViewController {
    private func collectionViewPerFormBatchUpdate() {
        if (!collectionView.allowsMultipleSelection) {
            var indexPaths: [IndexPath] = []
            
            if let sel = selectedItemIndexPath {
                indexPaths.append(sel)
            }
            
            if let desel = deselectedItemIndexPath {
                indexPaths.append(desel)
            }
            
            collectionView.performBatchUpdates {
                collectionView.reloadItems(at: indexPaths)
            }
        } else {
            if let indexPath = self.indexPathToUpdateAtMultipleSelection {
                collectionView.performBatchUpdates {
                    collectionView.reloadItems(at: [indexPath])
                }
            }
        }
    }
}

//IBAction
extension AutoHeightCellViewController {
    @IBAction private func didTapSelecButton() {
        self.collectionView.allowsMultipleSelection.toggle()
        self.selectModeButton.setTitle(self.collectionView.allowsMultipleSelection ? "Done" : "Select", for: .normal)
        self.selectedIndexPaths.removeAll()
        self.collectionView.reloadData()
        self.selectedItemIndexPath = nil
        self.deselectedItemIndexPath = nil
    }
}

//MARK: Collection view data source
extension AutoHeightCellViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StringConstants.collectionViewCell.autoHeightCell, for: indexPath) as! AutoHeightCollectionViewCell
        if (!collectionView.allowsMultipleSelection) {
            let isSelectedItem = indexPath == selectedItemIndexPath
            cell.render(number: items[indexPath.item], isSelectedItem: isSelectedItem, indexPath: indexPath.item)
        } else {
            let isSelectedItem = self.selectedIndexPaths.contains(indexPath)
            cell.render(number: items[indexPath.item], isSelectedItem: isSelectedItem, indexPath: indexPath.item)
        }
        return cell
    }
}

//MARK: collection view delegate flow layout
extension AutoHeightCellViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return minimumLineSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return minimumInteritemSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if (!self.collectionView.allowsMultipleSelection) {
            if indexPath == self.selectedItemIndexPath {
                self.selectedItemIndexPath = nil
                self.deselectedItemIndexPath = indexPath
            } else {
                self.deselectedItemIndexPath = self.selectedItemIndexPath
                self.selectedItemIndexPath = indexPath
            }
        } else {
            if self.selectedIndexPaths.contains(indexPath) {
                guard let index = self.selectedIndexPaths.firstIndex(of: indexPath) else {
                    return
                }
                self.selectedIndexPaths.remove(at: index)
                self.indexPathToUpdateAtMultipleSelection = indexPath
            } else {
                self.selectedIndexPaths.append(indexPath)
                self.indexPathToUpdateAtMultipleSelection = indexPath
            }
        }
        self.collectionViewPerFormBatchUpdate()
    }
    
    // context menu
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        return UIContextMenuConfiguration(identifier: indexPath as NSCopying, previewProvider: nil) { _ in
            let share = UIAction(title: "Chia sẻ", image: UIImage(systemName: "square.and.arrow.up")) { [weak self] _ in
                self?.logger.debug("Chia sẻ ảnh ở hàng \(indexPath.row)")
            }
            let delete = UIAction(title: "Xoá", image: UIImage(systemName: "trash"), attributes: .destructive) { [weak self] _ in
                self?.logger.debug("Đã xoá ảnh ở hàng \(indexPath.row)")
            }
            return UIMenu(title: "Tùy chọn", children: [share, delete])
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, previewForHighlightingContextMenuWithConfiguration configuration: UIContextMenuConfiguration) -> UITargetedPreview? {
        guard let indexPath = configuration.identifier as? IndexPath,
              let cell = collectionView.cellForItem(at: indexPath) as? MusicCollectionViewCell else { return nil }
        let parameters = UIPreviewParameters()
        parameters.backgroundColor = .clear
        return UITargetedPreview(view: cell.contentView, parameters: parameters)
    }

    func collectionView(_ collectionView: UICollectionView, previewForDismissingContextMenuWithConfiguration configuration: UIContextMenuConfiguration) -> UITargetedPreview? {
        guard let indexPath = configuration.identifier as? IndexPath,
              let cell = collectionView.cellForItem(at: indexPath) as? MusicCollectionViewCell else { return nil }
        cell.unHighlight()
        return UITargetedPreview(view: cell.contentView)
    }
    
    func collectionView(_ collectionView: UICollectionView, willPerformPreviewActionForMenuWith configuration: UIContextMenuConfiguration, animator: any UIContextMenuInteractionCommitAnimating) {
        guard let indexPath = configuration.identifier as? IndexPath else { return }
        if let cell = collectionView.cellForItem(at: indexPath) as? MusicCollectionViewCell {
            cell.tapHay()
        }
    }
}

extension AutoHeightCellViewController: UICollectionViewDragDelegate {
    func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: any UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        let item = items[indexPath.item]
        let provide = NSItemProvider(object: NSString(string: "music"))
        let dragItem = UIDragItem(itemProvider: provide)
        dragItem.localObject = item
        return [dragItem]
    }
}

extension AutoHeightCellViewController: UICollectionViewDropDelegate {
    func collectionView(_ collectionView: UICollectionView, canHandle session: any UIDropSession) -> Bool {
        true
    }
    
    func collectionView(_ collectionView: UICollectionView, dropSessionDidUpdate session: any UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UICollectionViewDropProposal {
        if session.localDragSession != nil {
            return UICollectionViewDropProposal(operation: .move)
        } else {
            return UICollectionViewDropProposal(operation: .copy)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, performDropWith coordinator: any UICollectionViewDropCoordinator) {
        guard let destinationIndexPath = coordinator.destinationIndexPath else {
            return
        }
        if let item = coordinator.items.first, let sourceIndexPath = item.sourceIndexPath {
            collectionView.performBatchUpdates {
                let movedItem = items.remove(at: sourceIndexPath.item)
                items.insert(movedItem, at: destinationIndexPath.item)
                collectionView.moveItem(at: sourceIndexPath, to: destinationIndexPath)
            }
            coordinator.drop(item.dragItem, toItemAt: destinationIndexPath)
            
//Xử lý khi khi drag and drop các selected item
            if (!collectionView.allowsMultipleSelection) {
//trong trường hợp allowMultipleSelection = false
//Nếu kéo thả trúng selected item thì đổi selectedItemIndexPath
                if (sourceIndexPath == self.selectedItemIndexPath) {
                    self.selectedItemIndexPath = destinationIndexPath
                } else if (destinationIndexPath == self.selectedItemIndexPath) {
                    self.selectedItemIndexPath = sourceIndexPath
                }
            } else {
//trong trường hợp allowMultipleSelection = false
//Có 4 case xảy ra
//in, in|out, out (2 TH hợp này không cần xử lý)
//in, out | out, in (xoá in và thêm out)
                if (self.selectedIndexPaths.contains(sourceIndexPath) && !self.selectedIndexPaths.contains(destinationIndexPath)) {
                    guard let index = self.selectedIndexPaths.firstIndex(of: sourceIndexPath) else {
                        return
                    }
                    self.selectedIndexPaths.remove(at: index)
                    
                    self.selectedIndexPaths.append(destinationIndexPath)
                } else if (!self.selectedIndexPaths.contains(sourceIndexPath) && self.selectedIndexPaths.contains(destinationIndexPath)) {
                    guard let index = self.selectedIndexPaths.firstIndex(of: destinationIndexPath) else {
                        return
                    }
                    self.selectedIndexPaths.remove(at: index)
                    
                    self.selectedIndexPaths.append(sourceIndexPath)
                }
            }
        }
    }
}
