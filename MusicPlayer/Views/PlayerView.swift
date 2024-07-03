//
//  PlayerView.swift
//  MusicPlayer
//
//  Created by Адам Табиев on 28.06.2024.
//

import SwiftUI

struct PlayerView: View {
    
    @StateObject var vm = ViewModel()
    @State private var showFiles = false
    @State private var showFullPlayer = true
    @Namespace private var plaeyrAnimation
    
    var frameImage: CGFloat {
        showFullPlayer ? 320 : 50
    }
    
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
                                .frame(width: frameImage, height: frameImage)
                            
                            if !showFullPlayer {
                                
                                /// Description
                                VStack(alignment: .leading) {
                                    Text("Name")
                                        .nameFont()
                                    Text("Unknown Artist")
                                        .artistFont()
                                }
                                .matchedGeometryEffect(id: "Description", in: plaeyrAnimation)
                                
                                Spacer()
                                
                                CustomButton(image: "play.fill", size: .title) {
                                    // action
                                }
                                
                            }
                        }
                        .padding()
                        .background(showFullPlayer ? .clear : .black.opacity(0.3))
                        .cornerRadius(10)
                        .padding()
                        
                        /// Full Player
                        if showFullPlayer {
                            
                            /// Discription
                            VStack {
                                Text("Name")
                                    .nameFont()
                                Text("Unknown Artist")
                                    .artistFont()
                            }
                            .matchedGeometryEffect(id: "Description", in: plaeyrAnimation)
                            .padding(.top)
                            
                            VStack {
                                /// Duration
                                HStack {
                                    Text("00:00")
                                    Spacer()
                                    Text("03:27")
                                }
                                .durationFont()
                                .padding()
                                
                                /// Slider
                                Divider()
                                
                                HStack(spacing: 40) {
                                    CustomButton(image: "backward.end.fill", size: .title2) {
                                        // action
                                    }
                                    CustomButton(image: "play.circle.fill", size: .largeTitle) {
                                        // action
                                    }
                                    CustomButton(image: "forward.end.fill", size: .title2) {
                                        // action
                                    }
                                }
                            }
                            .padding(.horizontal, 40)
                        }
                    }
                    .frame(height: showFullPlayer ? SizeConstant.fullPlayer : SizeConstant.miniPlayer)
                    .onTapGesture {
                        withAnimation(.spring) {
                            self.showFullPlayer.toggle()
                        }
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
    
    // MARK: - Methods
    private func CustomButton(image: String, size: Font, action: @escaping () -> ()) -> some View {
        Button {
            action()
        } label: {
            Image(systemName: image)
                .foregroundStyle(.white)
                .font(size)
        }
    }
}

#Preview {
    PlayerView()
}
