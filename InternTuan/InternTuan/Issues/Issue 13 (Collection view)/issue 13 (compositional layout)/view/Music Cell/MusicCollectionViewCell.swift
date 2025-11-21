//
//  MusicCollectionViewCell.swift
//  InternTuan
//
//  Created by Nguên Bản on 11/11/25.
//

import UIKit
import OSLog

class MusicCollectionViewCell: UICollectionViewCell {

    private let logger = Logger()
    
    private var randomNumber: Int = 0
    
    @IBOutlet private weak var songName: UILabel!
    @IBOutlet private weak var songWriter: UILabel!
    @IBOutlet private weak var dateRelease: UILabel!
    
    @IBOutlet private weak var nameView: UIView!
    @IBOutlet private weak var writerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 10
        self.randomNumber = Int.random(in: 1...2)
    }
    
    public func render(music: Music, isSelected: Int = 0) {
        self.songName.text = music.name
        self.songWriter.text = music.writer
        self.dateRelease.text = music.dateRelease
        self.backgroundColor = UIColor.lightGray
        
        if isSelected == 0  {
            self.unHighlight()
        } else if isSelected == 1 {
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
        case 1:
            hidden1line()
        default:
            hidden2line()
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
        default:
            hidden2line()
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
    }
}

//MARK: ibaction
extension MusicCollectionViewCell {
    @IBAction private func didTapHay() {
        self.tapHay()
    }
}

