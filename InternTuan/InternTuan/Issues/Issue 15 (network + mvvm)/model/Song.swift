//
//  Song.swift
//  InternTuan
//
//  Created by Nguên Bản on 28/11/25.
//

import Foundation

struct Song {
    let title: String
    let artist: String
    let duration: String
    let album: String
    
    init(title: String, artist: String, duration: String, album: String) {
        self.title = title
        self.artist = artist
        self.duration = duration
        self.album = album
    }
}

class DataManager {
    private static var sharedDataManager: DataManager = {
        let dataManager = DataManager()
        return dataManager
    }()
        
    class func shared() -> DataManager {
        return sharedDataManager
    }
    
    public func fetchData() -> [Song] {
        var songs: [Song] = []
        for i in (1...48) {
            let song = Song(title: "Song \(i)", artist: "Artist \(i)", duration: "3:45", album: "Album \(i)")
            songs.append(song)
        }
        return songs
    }
}
