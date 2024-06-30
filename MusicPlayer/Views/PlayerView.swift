//
//  PlayerView.swift
//  MusicPlayer
//
//  Created by Адам Табиев on 28.06.2024.
//

import SwiftUI

struct PlayerView: View {
    
    @StateObject var vm = ViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                BackgroundView()
                List {
                    ForEach(vm.songs) { song in
                        SongCell(song: song)
                    }
                }
                .listStyle(.plain)
            }
            
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        // Action
                    } label: {
                        Image(systemName: "plus")
                            .font(.title2)
                            .foregroundStyle(.white)
                    }
                }
            }
        }
    }
}

#Preview {
    PlayerView()
}
