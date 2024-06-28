//
//  Model.swift
//  MusicPlayer
//
//  Created by Адам Табиев on 28.06.2024.
//

import Foundation

struct SongModel: Identifiable {
    let id = UUID()
    let name: String
    let data: Data
    let artist: String?
    let coverImage: Data?
    let duration: TimeInterval?
}
