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

    let logger = Logger()
    
    private var musics: [Music] = []
    
    var selectedIndexPathToHighlight: IndexPath?
    var selectedIndexPathToUnhighlight: IndexPath?
    
    @IBOutlet private weak var hayLabel: UILabel!
    @IBOutlet private weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "flow layout"
        setupCollectionView()
        seedMusics() // Tạo 20 đối tượng Music
        collectionView.reloadData()
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
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        self.collectionView.allowsSelection = true
    }
    
    // Tạo 20 đối tượng Music cho dòng 16 (mảng musics)
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
        }
        self.musics = items
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
    func collectionView(_ collectionView: UICollectionView, shouldDeselectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        logger.debug("did select: \(indexPath.item)")
    }
    
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
//        logger.debug("did highlight \(indexPath.item)")
        self.selectedIndexPathToHighlight = indexPath
        if let cell = collectionView.cellForItem(at: selectedIndexPathToHighlight ?? indexPath) as? MusicCollectionViewCell {
            cell.highlight()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
//        logger.debug("did unhighlight \(indexPath.item)")
        if let unhighlightIndexPath = selectedIndexPathToUnhighlight {
            if let cell = collectionView.cellForItem(at: unhighlightIndexPath) as? MusicCollectionViewCell {
                cell.unHighlight()
            }
        }
        self.selectedIndexPathToUnhighlight = selectedIndexPathToHighlight
    }
}

//MARK: collection view datasource
extension Issue13FlowLayoutViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        musics.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StringConstants.collectionViewCell.musicCell, for: indexPath) as! MusicCollectionViewCell
        let music = musics[indexPath.item]
        cell.render(music)
        cell.Issue13FlowLayoutDlg = self
        return cell
    }
}

//MARK: CollectionViewDelegateFlowLayout
extension Issue13FlowLayoutViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (self.collectionView.frame.width - 10) / 2, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
    }
}

//MARK: Issue13FLDlg
extension Issue13FlowLayoutViewController: Issue13FLVCDelegate {
    func didTapHay(_ name: String) {
        self.changeHay(name)
    }
}

