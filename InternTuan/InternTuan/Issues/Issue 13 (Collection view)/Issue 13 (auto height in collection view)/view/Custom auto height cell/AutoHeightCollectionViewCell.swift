//
//  AutoHeightCollectionViewCell.swift
//  InternTuan
//
//  Created by Nguên Bản on 14/11/25.
//

import UIKit
import OSLog

class AutoHeightCollectionViewCell: UICollectionViewCell {

    private let loger = Logger()
    private var indexPath: Int = 0
    
    @IBOutlet private weak var textlabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    public func render(number: Int, isSelectedItem: Bool, indexPath: Int) {
        self.indexPath = indexPath
        
        switch number {
        case 1:
            self.textlabel.text = "\(indexPath) | 1. The String type bridges with the The String type bridges with the The String type bridges"
            break
        case 2:
            self.textlabel.text = "\(indexPath) | 2. Logging Error: Failed to initialize logging system due to time out. Log messages may be missing. If this issue persists, try setting IDEPreferLogStreaming=YES in the active scheme actions environment variables."
            break
        default:
            self.textlabel.text = "\(indexPath) | 3. Logging Error: Failed to initialize logging system due to time out. Log messages may be missing. If this issue persists, try setting IDEPreferLogStreaming=YES in the active scheme actions environment variables. Logging Error: Failed to initialize logging system due to time out. Log messages may be missing. If this issue persists, try setting IDEPreferLogStreaming=YES in the active scheme actions environment variables. this issue persists, try setting IDEPreferLogStreaming=YES in the active scheme actions environment variables."
            break
        }
        self.backgroundColor = UIColor.lightGray
        
        if isSelectedItem {
            highlight(number: indexPath)
        } else {
            unHighlight(number: indexPath)
        }
    }
    
    public func highlight(number: Int) {
        var text: String = ""
        
        switch number {
        case 1:
            text = "\(indexPath) | . Logging Error: Failed to initialize logging system due to time out. Log messages may be missing. If this issue persists, try setting IDEPreferLogStreaming=YES in the active scheme actions environment variables."
            break
        case 2:
            text = "\(indexPath) | . Logging Error: Failed to initialize logging system due to time out. Log messages may be missing. If this issue persists, try setting IDEPreferLogStreaming=YES in the active scheme actions environment variables. Logging Error: Failed to initialize logging system due to time out. Log messages may be missing. If this issue persists, try setting IDEPreferLogStreaming=YES in the active scheme actions environment variables. this issue persists, try setting IDEPreferLogStreaming=YES in the active scheme actions environment variables."
            break
        default:
            text = "\(indexPath) | . The String type bridges with the The String type bridges with the The String type bridges"
            break
        }
        
        let attributedString = NSAttributedString(
            string: text,
            attributes: [
                .strikethroughStyle: NSUnderlineStyle.single.rawValue,
                .strikethroughColor: UIColor.black
            ]
        )
        textlabel.attributedText = attributedString
        
        self.layer.borderColor = UIColor.blue.cgColor
        self.layer.borderWidth = 1
    }

    public func unHighlight(number: Int) {
        var text: String = ""
        
        switch number {
        case 1:
            text = "\(indexPath) | 1. The String type bridges with the The String type bridges with the The String type bridges"
            break
        case 2:
            text = "\(indexPath) | 2. Logging Error: Failed to initialize logging system due to time out. Log messages may be missing. If this issue persists, try setting IDEPreferLogStreaming=YES in the active scheme actions environment variables."
            break
        default:
            text = "\(indexPath) | 3. Logging Error: Failed to initialize logging system due to time out. Log messages may be missing. If this issue persists, try setting IDEPreferLogStreaming=YES in the active scheme actions environment variables. Logging Error: Failed to initialize logging system due to time out. Log messages may be missing. If this issue persists, try setting IDEPreferLogStreaming=YES in the active scheme actions environment variables. this issue persists, try setting IDEPreferLogStreaming=YES in the active scheme actions environment variables."
            break
        }
        
        let attributedString = NSAttributedString(
            string: text,
            attributes: [
                .strikethroughStyle: nil
            ]
        )
        textlabel.attributedText = attributedString
        
        self.layer.borderWidth = 0
    }
}

extension AutoHeightCollectionViewCell {
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}
