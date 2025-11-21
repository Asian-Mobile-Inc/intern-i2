//
//  MusicCollectionViewCell.swift
//  InternTuan
//
//  Created by Nguên Bản on 11/11/25.
//

import UIKit
import OSLog

class MusicCollectionViewCell: UICollectionViewCell {

    let logger = Logger()
    
    var randomNumber: Int = 0
    
    @IBOutlet private weak var songName: UILabel!
    @IBOutlet private weak var songWriter: UILabel!
    @IBOutlet private weak var dateRelease: UILabel!
    
    @IBOutlet private weak var nameView: UIView!
    @IBOutlet private weak var writerView: UIView!
    
    weak var Issue13FlowLayoutDlg: Issue13FLVCDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 10
        self.randomNumber = Int.random(in: 1...2)
    }
    
    public func render(music: Music, isSelected: Int = 0, width: CGFloat = 100) {
        
        self.songName.text = music.name
        self.songWriter.text = music.writer
        self.dateRelease.text = music.dateRelease
        self.backgroundColor = UIColor.lightGray
        
        if isSelected == 0  {
            self.unHighlight()
        } else if isSelected == 1{
            self.hidden1line()
        } else {
            self.hidden2line()
        }
        
    }
    
    public func renderToTestAutoHeight(music: Music, random: Int) {
        self.songName.text = music.name
        self.songWriter.text = music.writer
        self.dateRelease.text = music.dateRelease
        self.backgroundColor = UIColor.lightGray
        
        switch random {
        case 0:
            self.unHighlight()
            break
        case 1:
            hidden1line()
            break
        default:
            hidden2line()
            break
        }
    }

    public func hidden1line() {
        self.nameView.isHidden = true
    }
    
    public func hidden2line() {
        self.nameView.isHidden = true
        self.writerView.isHidden = true
    }
    
    public func highlight() {
        
        switch randomNumber {
        case 1:
            hidden1line()
            break
        default:
            hidden2line()
            break
        }
        
        UIView.animate(withDuration: 0.1, animations: {
            self.layoutIfNeeded()
        })
    }
    
    public func unHighlight() {
        
        self.writerView.isHidden = false
        self.nameView.isHidden = false
        
        self.layoutIfNeeded()
    }
}

//MARK: service
extension MusicCollectionViewCell {
    public func tapHay() {
        self.Issue13FlowLayoutDlg?.didTapHay(self.songName.text ?? "")
    }
}

//MARK: ibaction
extension MusicCollectionViewCell {
    @IBAction private func didTapHay() {
        self.tapHay()
    }
}

//MARK: preferedLayoutAttributes
//extension MusicCollectionViewCell {
//    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
//        let attributes = super.preferredLayoutAttributesFitting(layoutAttributes)
//        
//        guard let collectionView = self.superview as? UICollectionView else {
//            return attributes
//        }
//        
//        let colums: CGFloat = 2
//        var inset: UIEdgeInsets = .zero
//        var spacing: CGFloat = 8
//        
//        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
//            inset = flowLayout.sectionInset
//            spacing = flowLayout.minimumInteritemSpacing
//        }
//        
//        let availableWidth = collectionView.bounds.width - inset.left - inset.right
//        let totalSpacing = spacing * (colums - 1)
//        let width = (availableWidth - totalSpacing) / colums
//        
//        attributes.size.width = width
//        
//        contentView.setNeedsLayout()
//        contentView.layoutIfNeeded()
//        
//        let targetSize = CGSize(width: width, height: UIView.layoutFittingCompressedSize.height)
//        let itemSize = contentView.systemLayoutSizeFitting(
//            targetSize,
//            withHorizontalFittingPriority: .required,
//            verticalFittingPriority: .fittingSizeLevel)
//        
//        let height = itemSize.height
//        
//        logger.debug("height: \(height)")
//        
//        attributes.size.height = ceil(height)
//        
//        return attributes
//    }
//}
