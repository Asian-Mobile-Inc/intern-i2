//
//  AutoHeightCellViewController.swift
//  InternTuan
//
//  Created by Nguên Bản on 20/11/25.
//

import UIKit
import OSLog

class AutoHeightCellViewController: UIViewController {
    
    let logger = Logger()

    private let minimumLineSpacing: CGFloat = 10
    private let minimumInteritemSpacing: CGFloat = 10
    private let numOfColums: CGFloat = 1
    
    private var selectedItemIndexPath: IndexPath?
    private var deselectedItemIndexPath: IndexPath?
    
    private var items: [Int] = []
    
    @IBOutlet private weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupItems()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.setupCollectonView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        self.setupCollectonView()
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
        let isSelectedItem = indexPath == selectedItemIndexPath
        cell.render(number: items[indexPath.item], isSelectedItem: isSelectedItem, indexPath: indexPath.item)
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
        if indexPath == self.selectedItemIndexPath {
            self.selectedItemIndexPath = nil
            self.deselectedItemIndexPath = indexPath
        } else {
            self.deselectedItemIndexPath = self.selectedItemIndexPath
            self.selectedItemIndexPath = indexPath
        }
        self.collectionViewPerFormBatchUpdate()
    }
}
