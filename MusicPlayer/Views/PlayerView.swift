//
//  PlayerView.swift
//  MusicPlayer
//
//  Created by Адам Табиев on 28.06.2024.
//

import SwiftUI

struct PlayerView: View {
    
    @StateObject var vm = ViewModel()
    @State var showFiles = false
    @State private var showDetails = false 
    
    var body: some View {
        NavigationView {
            ZStack {
                
                BackgroundView()
                
                VStack {
                    List {
                        ForEach(vm.songs) { song in
                            SongCell(song: song, durationFormated: vm.durationFormatted)
                                .onTapGesture {
                                    vm.playAudio(song: song)
                                }
                        }
                    }
                    .listStyle(.plain)
                    
                    Spacer()
                    
                    // MARK: - Player
                    VStack {
                        
                        /// Mini Player
                        HStack {
                            Color.white
                                .frame(width: 40, height: 40)
                            
                            VStack(alignment: .leading) {
                                Text("Name")
                                    .nameFont()
                                Text("Unknown Artist")
                                    .artistFont()
                            }
                            
                            Spacer()
                            
                            Button {
                                // Действие при нажатии на кнопку
                            } label: {
                                Image(systemName: "play.fill")
                                    .foregroundStyle(.white)
                                    .font(.title)
                            }
                        }
                        .padding()
                        .background(.black.opacity(0.3))
                        .cornerRadius(10)
                        .padding()
                        
                        /// Full Player
                    }
                }
            }
            
            //NARK: - Navigation Bar
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showFiles.toggle()
                    } label: {
                        Image(systemName: "plus")
                            .font(.title2)
                            .foregroundStyle(.white)
                    }
                }
            }
            
            // MARK: - Files Sheet
            .sheet(isPresented: $showFiles, content: {
                ImportFileManager(songs: $vm.songs)
            })
        }
    }
}

#Preview {
    PlayerView()
}
