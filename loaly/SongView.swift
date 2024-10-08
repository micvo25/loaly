//
//  SongView.swift
//  loaly
//
//  Created by Salvatore D'Armetta on 1/23/24.
//

import SwiftUI
import AVFoundation


struct ActivityViewController: UIViewControllerRepresentable {
    let itemsToShare: URL

    func makeUIViewController(context: UIViewControllerRepresentableContext<ActivityViewController>) -> UIActivityViewController {
        return UIActivityViewController(activityItems: [itemsToShare], applicationActivities: nil)
    }

    func updateUIViewController(_ uiViewController: UIActivityViewController, context: UIViewControllerRepresentableContext<ActivityViewController>) {}
}

struct SongView: View {
    
    @EnvironmentObject var song: Song
    @ObservedObject var player: MidiPlayer
    @State private var showingExporter = false
    @State private var timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    @State private var showShareSheet = false
    @State private var totalTime: TimeInterval = 0.0
    @State private var currentTime: TimeInterval = 0.0
    @State private var showingAddScreen = false
    
    var body: some View {
        ZStack{
                   Color.yellow
                       .ignoresSafeArea()
                   songPlayer
        }
        .onAppear(perform: setupAudio)
        .onReceive(Timer.publish(every: 0.1, on: .main, in: .common).autoconnect())  { _ in
            updateProgress()
        }
        .onDisappear(){
            player.midiPlayer?.stop()
        }
        .toolbar{
            ToolbarItem(placement: .navigationBarTrailing) {
                Button{
                    showingAddScreen.toggle()
                }
                label:{
                    Label("Add Song", systemImage: "plus")
                }
            }
        }
        .sheet(isPresented: $showingAddScreen) {
            SaveSongView()
        }
    }
    
    private var songPlayer: some View{
        VStack(spacing: 10){
            HStack{
                Image("ostrich logo-02")
                    .resizable()
                    .frame(width: 300, height: 300)
                    .aspectRatio(contentMode: .fill)
            }
            HStack(spacing: 25){
                Button(action: {
                    do {
                        try AVAudioSession.sharedInstance().setCategory(.playback)
                    } catch(let error) {
                        print(error.localizedDescription)
                    }
                    Task{
                         await player.playSong()
                    }
                    
                }, label: {
                    Image(systemName: player.midiPlayer?.isPlaying ?? false ? "pause.fill" : "play.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 25, height: 25)
                        .accentColor(.black)
                })
                
            }
            HStack{
                Slider(value: Binding(get: {
                    currentTime
                }, set: {newValue in seekAudio(to: newValue)}), in: 0...totalTime)
                .accentColor(.black)
                .padding()
            }
            HStack{
                Text(timeString(time: currentTime))
                    .foregroundStyle(.black)
                    .padding()
                Spacer()
                Text(timeString(time: totalTime))
                    .foregroundStyle(.black)
                    .padding()
            }
            Spacer()
            HStack{
                Button(action: {
                    showShareSheet = true
                }, label: {
                    Image(systemName: "square.and.arrow.down.fill")
                        .accentColor(.black)
                        .imageScale(.large)
                })
            }
            .sheet(isPresented: $showShareSheet, content: {
                ActivityViewController(itemsToShare: getComposition())
            })
            Spacer()
        }
 
    }
    
    private func setupAudio() {
        totalTime = player.midiPlayer?.duration ?? 0.0
    }
    
    private func updateProgress(){
        currentTime = player.midiPlayer?.currentPosition ?? 0
    }
    
    private func seekAudio(to time: TimeInterval){
        player.midiPlayer?.currentPosition = time
    }
    
    private func timeString(time: TimeInterval) -> String{
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    private func getComposition() -> URL {
        let documentDirectoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first! as NSURL
        let songURL = documentDirectoryURL.appendingPathComponent("mySong.mid")
        
        guard MusicSequenceFileCreate(player.musicSequence!, songURL! as CFURL, MusicSequenceFileTypeID.midiType, MusicSequenceFileFlags.eraseFile, 0) == OSStatus(noErr) else{
            fatalError("Cannot create midi file")
        }
        return songURL!
    }
}

/*
       #Preview {
           SongView()
               .environmentObject(Song())
       }
*/
