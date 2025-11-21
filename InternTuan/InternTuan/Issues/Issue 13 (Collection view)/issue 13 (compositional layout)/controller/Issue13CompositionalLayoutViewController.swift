//
//  Issue13CompositionalLayoutViewController.swift
//  InternTuan
//
//  Created by Nguên Bản on 21/11/25.
//

import UIKit

class Issue13CompositionalLayoutViewController: UIViewController {

    private var items: [[Int]] = [[],[],[]]
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupItems()
        setupCollectionView()
    }
    
    private func creatLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { [weak self] sectionIndex, layoutEnviroment in
            guard let self = self else {
                return nil
            }
            
            switch sectionIndex {
            case 0:
                let itemSize = NSCollectionLayoutSize(
                    widthDimension: .absolute(60),
                    heightDimension: .absolute(60)
                )
                let item = NSCollectionLayoutItem(
                    layoutSize: itemSize
                )
                
                let groupSize = NSCollectionLayoutSize(
                    widthDimension: .absolute(60),
                    heightDimension: .absolute(60)
                )
                
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                section.interGroupSpacing = 10
                section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)
                return section
            case 1:
                let itemSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalHeight(1)
                )
                let item = NSCollectionLayoutItem(
                    layoutSize: itemSize
                )
                
                let groupSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(0.9),
                    heightDimension: .fractionalHeight(0.6)
                )
                
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                
                let section = NSCollectionLayoutSection(group: group)
                section.interGroupSpacing = 10
                section.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 10, bottom: 0, trailing: 10)
                section.orthogonalScrollingBehavior = .groupPagingCentered
                
                return section
            default:
                let finalGroupHeight: CGFloat = 360
                let leftColumnWidthFraction: CGFloat = 1.0 / 3.0
                let rightColumnWidthFraction: CGFloat = 1.0 - leftColumnWidthFraction

                let vItemSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .fractionalHeight(1.0 / 3.0)
                )
                let vItem = NSCollectionLayoutItem(layoutSize: vItemSize)
    //            vItem.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)

                let leftColumnSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(leftColumnWidthFraction),
                    heightDimension: .fractionalHeight(1.0)
                )
                let leftColumn = NSCollectionLayoutGroup.vertical(
                    layoutSize: leftColumnSize,
                    subitem: vItem,
                    count: 3
                )

                let bigItemSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .fractionalHeight(2.0 / 3.0)
                )
                let bigItem = NSCollectionLayoutItem(layoutSize: bigItemSize)
    //            bigItem.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)

                let hItemSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(0.5),
                    heightDimension: .fractionalHeight(1.0)
                )
                let hItem = NSCollectionLayoutItem(layoutSize: hItemSize)
    //            hItem.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)

                let bottomRightGroupSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .fractionalHeight(1.0 / 3.0)
                )
                let bottomRightGroup = NSCollectionLayoutGroup.horizontal(
                    layoutSize: bottomRightGroupSize,
                    subitem: hItem,
                    count: 2
                )

                let rightColumnSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(rightColumnWidthFraction),
                    heightDimension: .fractionalHeight(1.0)
                )
                let rightColumn = NSCollectionLayoutGroup.vertical(
                    layoutSize: rightColumnSize,
                    subitems: [bigItem, bottomRightGroup]
    //                subitems: [bottomRightGroup, bigItem]
                )

                // -----------------------------
                // 6) final group: left + right
                // -----------------------------
    //            let finalGroupSize = NSCollectionLayoutSize(
    //                widthDimension: .fractionalWidth(1.0),
    //                heightDimension: .absolute(finalGroupHeight)
    //            )
    //            let finalGroup = NSCollectionLayoutGroup.horizontal(
    //                layoutSize: finalGroupSize,
    //                subitems: [leftColumn, rightColumn]
    //                subitems: [rightColumn, leftColumn]
    //            )
                
                let topFinalGroupSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalHeight(1.0 / 2.0)
                )
                
                let topFinalGroup = NSCollectionLayoutGroup.horizontal(
                    layoutSize: topFinalGroupSize,
                    subitems: [leftColumn, rightColumn]
    //                subitems: [rightColumn, leftColumn]
                )
                
                let botFinalGroupSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalHeight(1.0 / 2.0)
                )
                
                let botFinalGroup = NSCollectionLayoutGroup.horizontal(
                    layoutSize: botFinalGroupSize,
    //                subitems: [leftColumn, rightColumn]
                    subitems: [rightColumn, leftColumn]
                )
                let finalGroupSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .absolute(finalGroupHeight * 2)
                )
                
                let finalGroup = NSCollectionLayoutGroup.vertical(
                    layoutSize: finalGroupSize,
                    subitems: [topFinalGroup, botFinalGroup]
                )

                let section = NSCollectionLayoutSection(group: finalGroup)
    //            section.interGroupSpacing = 12
                section.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 10, bottom: 20, trailing: 10)
//                section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
//                section.orthogonalScrollingBehavior = .groupPaging
//                section.orthogonalScrollingBehavior = .groupPagingCentered
//                section.orthogonalScrollingBehavior = .paging
                return section
            }
        }
    }
    
    private func setupItems() {
        for i in (0...2) {
            for _ in (1...48) {
                let randomNumber = Int.random(in: 1...3)
                self.items[i].append(randomNumber)
            }
        }
    }
    
    static func instantiate() -> Issue13CompositionalLayoutViewController {
        return Issue13CompositionalLayoutViewController(nibName: StringConstants.viewController.issue13CompositionalLayoutVC, bundle: nil)
    }
}

//MARK: setup
extension Issue13CompositionalLayoutViewController {
    private func setupCollectionView() {
        let textCellNib = UINib(nibName: StringConstants.collectionViewCell.autoHeightCell, bundle: nil)
        self.collectionView.register(textCellNib, forCellWithReuseIdentifier: StringConstants.collectionViewCell.autoHeightCell)
        
        let musicCellNib = UINib(nibName: StringConstants.collectionViewCell.musicCell, bundle: nil)
        self.collectionView.register(musicCellNib, forCellWithReuseIdentifier: StringConstants.collectionViewCell.musicCell)
        
        self.collectionView.dataSource = self
        self.collectionView.collectionViewLayout = creatLayout()
    }
}

//MARK: collection view datasource
extension Issue13CompositionalLayoutViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StringConstants.collectionViewCell.autoHeightCell, for: indexPath) as! AutoHeightCollectionViewCell
            cell.render(number: items[indexPath.section][indexPath.item], isSelectedItem: true, indexPath: indexPath.item)
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StringConstants.collectionViewCell.musicCell, for: indexPath) as! MusicCollectionViewCell
            let music = Music(name: "Cho toi di theo", writer: "Ang Ot", dateRelease: "2016")
            cell.render(music: music, isSelected: 0)
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StringConstants.collectionViewCell.autoHeightCell, for: indexPath) as! AutoHeightCollectionViewCell
            cell.render(number: items[indexPath.section][indexPath.item], isSelectedItem: true, indexPath: indexPath.item)
            return cell
        }
    }
}
