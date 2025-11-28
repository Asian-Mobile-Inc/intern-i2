//
//  Issue15MainViewModel.swift
//  InternTuan
//
//  Created by Nguên Bản on 28/11/25.
//

import Foundation
import Combine

class Issue15MainViewModel {
    
    @Published var songs: [Song] = []
    
    let dataManager = DataManager.shared()
    
    public func fetchData() {
        self.songs = dataManager.fetchData()
        
    }
}
