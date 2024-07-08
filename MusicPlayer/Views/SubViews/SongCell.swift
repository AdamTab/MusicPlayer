//
//  SongCell.swift
//  MusicPlayer
//
//  Created by Адам Табиев on 28.06.2024.
//

import SwiftUI

struct SongCell: View {
    
    let song: SongModel
    let durationFormated: (TimeInterval) -> String
    
    var body: some View {
        HStack {
            SongImageView(imageData: song.coverImage, size: 60)
            
            VStack(alignment: .leading) {
                Text(song.name)
                    .nameFont()
                Text(song.artist ?? "Unknow Artist")
                    .artistFont()
            }
            
            Spacer()
            
            if let duration = song.duration {
                Text(durationFormated(duration))
                    .artistFont()
            }
        }
        .listRowBackground(Color.clear)
        .listRowSeparator(.hidden)
    }
}

#Preview {
    PlayerView()
}
