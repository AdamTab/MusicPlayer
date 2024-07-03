//
//  ViewModel.swift
//  MusicPlayer
//
//  Created by Адам Табиев on 28.06.2024.
//

import Foundation

class ViewModel: ObservableObject {
    @Published var songs: [SongModel] = []
}
