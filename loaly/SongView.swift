//
//  SongView.swift
//  loaly
//
//  Created by Salvatore D'Armetta on 1/23/24.
//

import SwiftUI
import AVFoundation

/*
class AudioPlayerViewModel: ObservableObject {
    
    let sound: URL
    var audioPlayer: AVAudioPlayer?
    @Published var isPlaying = false

  init() {
      let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
      self.sound = documentsDirectory.appendingPathComponent("LOAComposition.m4a")
      let soundPath = sound.path
      do {
        audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: soundPath))
      } catch {
          print(error.localizedDescription)
      }
   
      do {
          try AVAudioSession.sharedInstance().setCategory(.playback)
      } catch let error {
          print(error.localizedDescription)
      }
      
  }

func documentDirectory() -> URL {
    let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    return documentsDirectory
}

  func playOrPause() {
    guard let player = audioPlayer else { return }

      if player.isPlaying {
      player.pause()
      isPlaying = false
    } else {
      player.play()
      isPlaying = true
    }
      
      do {
          try AVAudioSession.sharedInstance().setCategory(.playback)
      } catch let error {
          print(error.localizedDescription)
      }
  }
    
    func loadNewFile(file: URL){
        do {
            audioPlayer = try AVAudioPlayer(contentsOf:  file)
        }
        catch{
            print(error.localizedDescription)
        }
    }
}
*/
struct SongView: View {
    
    var audioPlayerViewModel: AudioPlayerViewModel
    @State private var showingExporter = false
    
    var body: some View {
        ZStack{
                   Color.yellow
                       .ignoresSafeArea()
            
                   VStack(spacing: 50){
                       HStack{
                           Image("ostrich logo-02")
                               .resizable()
                               .frame(width: 300, height: 300)
                               .aspectRatio(contentMode: .fill)
                       }
                       HStack(spacing: 25){
                           Button(action: {
                               audioPlayerViewModel.playOrPause()
                               
                           }, label: {
                               Image(systemName: audioPlayerViewModel.isPlaying ? "pause.fill" : "play.fill")
                                   .resizable()
                                   .scaledToFit()
                                   .frame(width: 25, height: 25)
                                   .accentColor(.black)
                           })
                           ShareLink(item: getComposition())
                               .labelStyle(.iconOnly)
                               .imageScale(.large)
                               .accentColor(.black)
                               .symbolVariant(.fill)
                           
                       }
                       Spacer()
                   }
                   
                   .onDisappear(){
                       if audioPlayerViewModel.isPlaying {
                           audioPlayerViewModel.audioPlayer?.pause()
                           audioPlayerViewModel.isPlaying = false
                       }
                   }
            
               }
    }
    func getComposition() -> URL {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let composition = documentsDirectory.appendingPathComponent("LOAComposition.m4a")
        return composition
    }
}

       #Preview {
           SongView(audioPlayerViewModel: AudioPlayerViewModel())
       }
