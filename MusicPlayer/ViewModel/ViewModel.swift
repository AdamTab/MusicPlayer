//
//  ViewModel.swift
//  MusicPlayer
//
//  Created by Адам Табиев on 28.06.2024.
//

import Foundation
import AVFAudio

class ViewModel: ObservableObject {
    @Published var songs: [SongModel] = []
    @Published var audioPlayer: AVAudioPlayer?
    @Published var isPlaying = false
    
    // MARK: - Methods
    func playAudio(song: SongModel) {
        do {
            self.audioPlayer = try AVAudioPlayer(data: song.data)
            self.audioPlayer?.play()
            isPlaying = true
        } catch {
            print("Error in audio playback: \(error.localizedDescription)")
        }
    }
    
    func durationFormatted(duration: TimeInterval) -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.minute, .second]
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = .pad
        return formatter.string(from: duration) ?? ""
    }
}
