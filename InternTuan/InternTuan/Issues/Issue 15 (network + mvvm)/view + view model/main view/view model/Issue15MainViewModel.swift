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
        Task {
            do {
                // Gọi API /users
                let users: [User] = try await APIService.shared.request(target: UserAPI.getAll)
                
                // Map User -> Song để khớp UI
                let mappedSongs: [Song] = users.map { user in
                    Song(
                        title: user.name,
                        artist: user.username,
                        duration: "3:45",                // dữ liệu demo
                        album: user.email                // hiển thị đại diện
                    )
                }
                
                await MainActor.run {
                    self.songs = mappedSongs
                }
            } catch {
                await MainActor.run {
                    self.songs = []
                }
                debugPrint("Fetch songs failed: \(error)")
            }
        }
    }
}
