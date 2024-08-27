//
//  DetailSongView.swift
//  loaly
//
//  Created by Salvatore D'Armetta on 7/22/24.
//
import SwiftUI
import AVFoundation

struct DetailSongView: View {
    
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var song: Song
    
    @ObservedObject var detailViewPlayer: MidiPlayer
    
    @State private var showingExporter = false
    @State private var timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    @State private var showShareSheet = false
    @State private var totalTime: TimeInterval = 0.0
    @State private var currentTime: TimeInterval = 0.0
    @State private var showingAddScreen = false
    
    let userSong: UserSong
    
    var body: some View {
        ZStack{
                   Color.yellow
                       .ignoresSafeArea()
                       .navigationBarBackButtonHidden()
                       .toolbar{
                           ToolbarItem(placement: .navigationBarLeading, content: {
                               Button{
                                   detailViewPlayer.midiPlayer?.stop()
                                   dismiss()
                               } label: {
                                   HStack{
                                       Image(systemName: "chevron.backward")
                                   }
                               }
                           })
                       }
                   detailSongPlayer
            
        }
        .onAppear(perform: setupAudio)
        .onReceive(Timer.publish(every: 0.1, on: .main, in: .common).autoconnect())  { _ in
            updateProgress()
        }
        .onDisappear(){
            detailViewPlayer.midiPlayer?.stop()
            print("ON DISAPPEAR ACTIVATED")
        }
    }
    
    private var detailSongPlayer: some View{
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
                         await detailViewPlayer.playSong()
                    }
                    
                }, label: {
                    Image(systemName: detailViewPlayer.midiPlayer?.isPlaying ?? false ? "pause.fill" : "play.fill")
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
        totalTime = detailViewPlayer.midiPlayer?.duration ?? 0.0
    }
    
    private func updateProgress(){
        currentTime = detailViewPlayer.midiPlayer?.currentPosition ?? 0
    }
    
    private func seekAudio(to time: TimeInterval){
        detailViewPlayer.midiPlayer?.currentPosition = time
    }
    
    private func timeString(time: TimeInterval) -> String{
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    func getComposition() -> URL {
        let documentDirectoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first! as NSURL
        let songURL = documentDirectoryURL.appendingPathComponent("mySong.mid")
        
        guard MusicSequenceFileCreate(detailViewPlayer.musicSequence!, songURL! as CFURL, MusicSequenceFileTypeID.midiType, MusicSequenceFileFlags.eraseFile, 0) == OSStatus(noErr) else{
            fatalError("Cannot create midi file")
        }
        return songURL!
    }
}
/*
 #Preview {
 DetailSongView()
 }
 */
