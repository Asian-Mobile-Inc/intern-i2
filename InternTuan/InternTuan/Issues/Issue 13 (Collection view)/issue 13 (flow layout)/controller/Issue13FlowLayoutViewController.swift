//
//  Issue13FlowLayoutViewController.swift
//  InternTuan
//
//  Created by Nguên Bản on 11/11/25.
//

import UIKit
import OSLog

protocol Issue13FLVCDelegate: AnyObject {
    func didTapHay(_ name: String)
}

final class Issue13FlowLayoutViewController: UIViewController {

    private let logger = Logger()
    private var randomNums: [Int] = []
    private var multipleSelectedItems: [IndexPath] = []
    private var musics: [Music] = []
    
    private var selectedIndexPathToHighlight: IndexPath?
    private var selectedIndexPathToUnhighlight: IndexPath?
    
    @IBOutlet private weak var hayLabel: UILabel!
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var selectModeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "flow layout"
        setupCollectionView()
        seedMusics()
        collectionView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        logger.debug("randomNumber: \(self.randomNums)")
    }
    
    static func instantiate() -> Issue13FlowLayoutViewController {
        return Issue13FlowLayoutViewController(nibName: StringConstants.viewController.issue13FlowLayoutVC, bundle: nil)
    }
    
}

//MARK: setup
extension Issue13FlowLayoutViewController {
    private func setupCollectionView() {
        let cellNib = UINib(nibName: StringConstants.collectionViewCell.musicCell, bundle: nil)
        self.collectionView.register(cellNib, forCellWithReuseIdentifier: StringConstants.collectionViewCell.musicCell)
        self.collectionView.register(UINib(nibName: "AutoHeightCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "AutoHeightCollectionViewCell")
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        self.collectionView.allowsSelection = true
        
        self.collectionView.dragDelegate = self
        self.collectionView.dropDelegate = self
        self.collectionView.dragInteractionEnabled = true
        
        self.collectionView.allowsMultipleSelection = false
    }
    
    private func seedMusics() {
        let names = [
            "Song A","Song B","Song C","Song D","Song E",
            "Song F","Song G","Song H","Song I","Song J",
            "Song K","Song L","Song M","Song N","Song O",
            "Song P","Song Q","Song R","Song S","Song T"
        ]
        let writers = [
            "Writer 1","Writer 2","Writer 3","Writer 4","Writer 5",
            "Writer 6","Writer 7","Writer 8","Writer 9","Writer 10",
            "Writer 11","Writer 12","Writer 13","Writer 14","Writer 15",
            "Writer 16","Writer 17","Writer 18","Writer 19","Writer 20"
        ]
        let dates = [
            "2020","2020","2021","2021","2021",
            "2022","2022","2022","2023","2023",
            "2023","2024","2024","2024","2024",
            "2025","2025","2025","2025","2025"
        ]
        
        var items: [Music] = []
        for i in 0..<20 {
            let music = Music(name: names[i], writer: writers[i], dateRelease: dates[i])
            items.append(music)
            let random = Int.random(in: 1...2)
            self.randomNums.append(random)
        }
        self.musics = items
    }
}

//MARK: IBAction
extension Issue13FlowLayoutViewController {
    @IBAction private func tapSelect() {
        self.collectionView.allowsMultipleSelection.toggle()
        logger.debug("multiple select mode: \(self.collectionView.allowsMultipleSelection)")
        self.selectModeButton.setTitle(self.collectionView.allowsMultipleSelection ? "Done" : "Select", for: .normal)
        self.multipleSelectedItems.removeAll()
        self.collectionView.reloadData()
    }
}

//MARK: service
extension Issue13FlowLayoutViewController {
    private func changeHay(_ name: String) {
        self.hayLabel.text = "\(name) Hayyyy!!!"
    }
}

//MARK: collection view delegate
extension Issue13FlowLayoutViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        true
    }
    func collectionView(_ collectionView: UICollectionView, shouldDeselectItemAt indexPath: IndexPath) -> Bool {
        true
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if (indexPath == selectedIndexPathToHighlight) {
            if (!collectionView.allowsMultipleSelection) {
                if let indexPathToReload = self.selectedIndexPathToHighlight {
                    self.selectedIndexPathToHighlight = nil
                    self.collectionView.reloadItems(at: [indexPathToReload])
                }
            }
        } else {
            if (!collectionView.allowsMultipleSelection) {
                if let indexPathToReload = self.selectedIndexPathToHighlight {
                    self.selectedIndexPathToHighlight = indexPath
                    self.collectionView.reloadItems(at: [indexPathToReload])
                }
            }
            if (collectionView.allowsMultipleSelection) {
                self.multipleSelectedItems.append(indexPath)
            }
            self.selectedIndexPathToHighlight = indexPath
            self.collectionView.reloadItems(at: [indexPath])
        }
    }
    
    // context menu
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        return UIContextMenuConfiguration(identifier: indexPath as NSCopying, previewProvider: nil) { _ in
            let share = UIAction(title: "Chia sẻ", image: UIImage(systemName: "square.and.arrow.up")) { [weak self] _ in
                self?.logger.debug("Chia sẻ ảnh ở hàng \(indexPath.row)")
                self?.hayLabel.text = "da chia se"
            }
            let delete = UIAction(title: "Xoá", image: UIImage(systemName: "trash"), attributes: .destructive) { [weak self] _ in
                self?.logger.debug("Đã xoá ảnh ở hàng \(indexPath.row)")
                self?.hayLabel.text = "da xoa"
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

//MARK: collection view datasource
extension Issue13FlowLayoutViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int { 1 }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.musics.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StringConstants.collectionViewCell.musicCell, for: indexPath) as! MusicCollectionViewCell
        logger.debug("\(cell)")
        let width = ((self.collectionView.bounds.width - 30) - 10) / 2
        if (!collectionView.allowsMultipleSelection) {
            let isSelected = indexPath == selectedIndexPathToHighlight
            if (isSelected) {
                cell.render(music: musics[indexPath.item], isSelected: self.randomNums[indexPath.item], width: width)
            } else {
                cell.render(music: musics[indexPath.item], isSelected: 0, width: width)
            }
        } else {
            let isSelected = self.multipleSelectedItems.contains(indexPath)
            if (isSelected) {
                cell.render(music: musics[indexPath.item], isSelected: self.randomNums[indexPath.item], width: width)
            } else {
                cell.render(music: musics[indexPath.item], isSelected: 0, width: width)
            }
        }
        return cell
    }
}

//MARK: CollectionViewDelegateFlowLayout
extension Issue13FlowLayoutViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.size.width - 50, height: 300)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
    }
}

//MARK: Issue13FLDlg
extension Issue13FlowLayoutViewController: Issue13FLVCDelegate {
    func didTapHay(_ name: String) {
        self.changeHay(name)
    }
}

extension Issue13FlowLayoutViewController: UICollectionViewDragDelegate {
    func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: any UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        let item = musics[indexPath.item]
        let provide = NSItemProvider(object: NSString(string: "music"))
        let dragItem = UIDragItem(itemProvider: provide)
        dragItem.localObject = item
        return [dragItem]
    }
}

extension Issue13FlowLayoutViewController: UICollectionViewDropDelegate {
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
        guard let destinationIndexPath = coordinator.destinationIndexPath else { return }
        if let item = coordinator.items.first, let sourceIndexPath = item.sourceIndexPath {
            collectionView.performBatchUpdates {
                let movedItem = musics.remove(at: sourceIndexPath.item)
                musics.insert(movedItem, at: destinationIndexPath.item)
                collectionView.moveItem(at: sourceIndexPath, to: destinationIndexPath)
            }
            coordinator.drop(item.dragItem, toItemAt: destinationIndexPath)
        }
    }
}
