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
    }
    enum viewController {
        static let issue10VC = "Issue10ViewController"
        static let issue11VC = "Issue11ViewController"
        static let issue11DetailVC = "Issue11DetailViewController"
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
