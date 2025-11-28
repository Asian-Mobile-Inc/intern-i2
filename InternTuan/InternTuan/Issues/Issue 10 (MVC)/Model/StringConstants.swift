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
        static let autoHeightCell = "AutoHeightCollectionViewCell"
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
        static let autoHeightCellVC = "AutoHeightCellViewController"
        static let issue13CompositionalLayoutVC = "Issue13CompositionalLayoutViewController"
        static let issue14MainVC = "Issue14MainViewController"
        static let issue14TabbarController = "Issue14DefaultTabbarController"
        static let issue14HomeVC = "Issue14HomeViewConroller"
        static let issue14SettingVC = "Issue14SettingViewConroller"
        static let issue14ProfileVC = "Issue14ProfileViewController"
        static let issue15MainVC = "Issue15MainViewController"
    }
    enum notification {
        enum name {
            static let didFetchStudentList = "didFetchStudentList"
        }
        enum userInfo {
            static let students = "students"
        }
    }
    
    enum customView {
        static let customTabBar = "CustomTabbar"
    }
}
