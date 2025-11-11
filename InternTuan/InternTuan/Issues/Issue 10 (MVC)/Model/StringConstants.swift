//
//  StringConstants.swift
//  InternTuan
//
//  Created by Nguên Bản on 20/10/25.
//

import Foundation

enum StringConstants {
    enum tableViewCell {
        static let studentTableViewCell = "StudentTableViewCell"
        static let cell = "cell"
        static let issue11DDScell = "Issue11DDSTableViewCell"
    }
    
    enum collectionViewCell {
        static let musicCell = "MusicCollectionViewCell"
    }
    
    enum header {
        static let header = "HeaderView"
    }
    
    enum viewController {
        static let issue10VC = "Issue10ViewController"
        static let issue11MainVC = "Issue11MainViewController"
        static let issue11VC = "Issue11ViewController"
        static let issue11DetailVC = "Issue11DetailViewController"
        static let issue11DDSVC = "Issue11DDSViewController"
        static let issue11DragnDropVC = "Issue11DragNDropViewController"
        static let issue12VC = "Issue12ViewController"
        static let issue13VC = "Issue13MainViewController"
        static let issue13FlowLayoutVC = "Issue13FlowLayoutViewController"
    }
    enum notification {
        enum name {
            static let didFetchStudentList = "didFetchStudentList"
        }
        enum userInfo {
            static let students = "students"
        }
    }
}
