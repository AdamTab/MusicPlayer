//
//  SongCell.swift
//  MusicPlayer
//
//  Created by Адам Табиев on 28.06.2024.
//

import SwiftUI

struct SongCell: View {
    
    let song: SongModel
    
    var body: some View {
        HStack {
            Color.white
                .frame(width: 60, height: 60)
                .cornerRadius(10)
            
            VStack(alignment: .leading) {
                Text(song.name)
                    .nameFont()
                Text(song.artist ?? "Unknow Artist")
                    .artistFont()
            }
            
            Spacer()
            
            Text("03:48")
                .artistFont()
        }
        .listRowBackground(Color.clear)
        .listRowSeparator(.hidden)
    }
}

#Preview {
    SongCell(song: SongModel(name: "Hurt", data: Data(), artist: "Johnny Cash", coverImage: Data(), duration: 0))
}
