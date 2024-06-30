//
//  ViewModel.swift
//  MusicPlayer
//
//  Created by Адам Табиев on 28.06.2024.
//

import Foundation

class ViewModel: ObservableObject {
    @Published var songs: [SongModel] = [
        SongModel(
            name: "Chop Suey",
            data: Data(),
            artist: "System of a Down",
            coverImage: Data(),
            duration: 0
        ),
        SongModel(
            name: "Vermillion",
            data: Data(),
            artist: "Slipknot",
            coverImage: Data(),
            duration: 0
        ),
        SongModel(
            name: "Fields of gold",
            data: Data(),
            artist: "Sting",
            coverImage: Data(),
            duration: 0
        )
    ]
}
