//
//  MusicCollectionViewCell.swift
//  InternTuan
//
//  Created by Nguên Bản on 11/11/25.
//

import UIKit

class MusicCollectionViewCell: UICollectionViewCell {

    
    @IBOutlet private weak var songName: UILabel!
    @IBOutlet private weak var songWriter: UILabel!
    @IBOutlet private weak var dateRelease: UILabel!
    @IBOutlet private weak var background: UIView!
    
    weak var Issue13FlowLayoutDlg: Issue13FLVCDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.background.layer.cornerRadius = 10
    }
    
    public func render(_ music: Music) {
        self.songName.text = music.name
        self.songWriter.text = music.writer
        self.dateRelease.text = music.dateRelease
    }

    public func highlight() {
        self.background.layer.borderWidth = 2
        self.background.layer.borderColor = UIColor.blue.cgColor
        
        UIView.animate(withDuration: 0.1, animations: {
            self.layoutIfNeeded()
        })
    }
    
    public func unHighlight() {
        self.background.layer.borderWidth = 0
        
        UIView.animate(withDuration: 0.1, animations: {
            self.layoutIfNeeded()
        })
    }
}

//MARK: ibaction
extension MusicCollectionViewCell {
    @IBAction private func didTapHay() {
        self.Issue13FlowLayoutDlg?.didTapHay(self.songName.text ?? "")
    }
}
