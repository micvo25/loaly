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
    
    //@EnvironmentObject var audioPlayerViewModel: AudioPlayerViewModel
    @EnvironmentObject var song: Song
    @EnvironmentObject var player: MidiPlayer
    @State private var showingExporter = false
    @State private var timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    @State var showShareSheet = false
    @State private var totalTime: TimeInterval = 0.0
    @State private var currentTime: TimeInterval = 0.0
    
    var body: some View {
        ZStack{
                   Color.yellow
                       .ignoresSafeArea()
            
                   VStack(spacing: 10){
                       HStack{
                           Image("ostrich logo-02")
                               .resizable()
                               .frame(width: 300, height: 300)
                               .aspectRatio(contentMode: .fill)
                       }
                       HStack(spacing: 25){
                           Button(action: {
                               
                               Task{
                                   do{
                                       await player.playSong()
                                   }
                                   catch{
                                       print(error)
                                   }
                               }
                                
                               
                           }, label: {
                               Image(systemName: player.midiPlayer!.isPlaying ? "pause.fill" : "play.fill")
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
                               Image(systemName: "square.and.arrow.up.fill")
                                   .accentColor(.black)
                                   .imageScale(.large)
                           })
                           .padding()
                           .padding()
                           Spacer()
                       }
                       .sheet(isPresented: $showShareSheet, content: {
                           ActivityViewController(itemsToShare: getComposition())
                       })
                   }
            
        }
        .onAppear(perform: setupAudio)
        .onReceive(Timer.publish(every: 0.1, on: .main, in: .common).autoconnect())  { _ in
            updateProgress()
        }
    }
    func getComposition() -> URL {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let composition = documentsDirectory.appendingPathComponent("LOAComposition.m4a")
        return composition
    }
    
    private func setupAudio() {
        do{
            totalTime = player.midiPlayer?.duration ?? 0.0
        }
        catch{
            print(error)
        }
    }
    
    private func updateProgress(){
        currentTime = player.midiPlayer!.currentPosition
    }
    
    private func seekAudio(to time: TimeInterval){
        player.midiPlayer?.currentPosition = time
    }
    
    private func timeString(time: TimeInterval) -> String{
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        
        return String(format: "%02d:%02d", minutes, seconds)
    }
}


       #Preview {
           SongView()
               .environmentObject(Song())
       }
