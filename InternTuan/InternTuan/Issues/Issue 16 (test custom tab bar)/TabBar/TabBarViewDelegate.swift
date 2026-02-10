//
//  TabBarViewDelegate.swift
//  InternTuan
//
//  Created by Tuan on 10/2/26.
//

import Foundation

protocol TabBarViewDelegate: AnyObject {
    func tabBarView(_ view: TabBarView, didSelect tab: Tab)
}
