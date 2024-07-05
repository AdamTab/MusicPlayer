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
    @State private var showFullPlayer = false
    @State private var isDragging = false
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
                    if vm.currentSong != nil {
                        Player()
            
                        .frame(height: showFullPlayer ? SizeConstant.fullPlayer : SizeConstant.miniPlayer)
                        .onTapGesture {
                            withAnimation(.spring) {
                                self.showFullPlayer.toggle()
                            }
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
   // @ViewBuilder
    private func Player() -> some View {
        VStack {

            /// Mini Player
            HStack {
                
                /// Cover
                if let data = vm.currentSong?.coverImage, let uiImage = UIImage(data: data) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: frameImage, height: frameImage)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                } else {
                    ZStack {
                        Color.gray
                            .frame(width: frameImage, height: frameImage)
                        Image(systemName: "music.note")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 30)
                            .foregroundColor(.white)
                    }
                    .cornerRadius(10)
                }
                
                if !showFullPlayer {
                    
                    /// Description
                    VStack(alignment: .leading) {
                        SonhDescription()
                    }
                    .matchedGeometryEffect(id: "Description", in: plaeyrAnimation)
                    
                    Spacer()
                    
                    CustomButton(image: vm.isPlaying ? "pause.fill" : "play.fill", size: .title) {
                        vm.playPause()                    }
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
                    SonhDescription()
                }
                .matchedGeometryEffect(id: "Description", in: plaeyrAnimation)
                .padding(.top)
                
                VStack {
                    /// Duration
                    HStack {
                        Text("\(vm.durationFormatted(duration: vm.currentTime))")
                        Spacer()
                        Text("\(vm.durationFormatted(duration: vm.totalTime))")
                    }
                    .durationFont()
                    .padding()
                    
                    /// Slider
                    Slider(value: $vm.currentTime, in: 0...vm.totalTime) { editing in
                        isDragging = editing
                        
                        if !editing {
                            vm.seekAudio(time: vm.currentTime)
                        }
                    }
                    .offset(y: -18)
                    .accentColor(.white)
                    .onAppear {
                        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                            vm.updateProgress()
                        }
                    }
                    
                    HStack(spacing: 40) {
                        CustomButton(image: "backward.end.fill", size: .title2) {
                            // action
                        }
                        CustomButton(image: vm.isPlaying ? "pause.circle.fill" : "play.circle.fill", size: .largeTitle) {
                            vm.playPause()
                        }
                        CustomButton(image: "forward.end.fill", size: .title2) {
                            // action
                        }
                    }
                }
                .padding(.horizontal, 40)
            }
        }
    }
    
    private func CustomButton(image: String, size: Font, action: @escaping () -> ()) -> some View {
        Button {
            action()
        } label: {
            Image(systemName: image)
                .foregroundStyle(.white)
                .font(size)
        }
    }
    
    @ViewBuilder
    private func SonhDescription() -> some View {
        if let currentSong = vm.currentSong {
            Text(currentSong.name)
                .nameFont()
            Text(currentSong.artist ?? "Unknown Artist")
                .artistFont()
        }
    }
    
}

#Preview {
    PlayerView()
}
