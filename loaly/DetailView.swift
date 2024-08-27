//
//  DetailView.swift
//  loaly
//
//  Created by Salvatore D'Armetta on 7/20/24.
//

import SwiftUI
import AVFoundation

struct DetailView: View {
    @ObservedObject var detailViewPlayer: MidiPlayer
    let userSong: UserSong
    
    var body: some View {
        
        ZStack{
            Color.yellow
                .ignoresSafeArea()
            if #available(iOS 16.0, *) {
                List{
                    Section{
                        Text("\(userSong.songText ?? "")")
                    }
                    Section{
                        NavigationLink{
                            DetailSongView(detailViewPlayer: detailViewPlayer, userSong: userSong)
                        } label:{
                            Text("Play Song")
                        }
                    }
                }
                .scrollContentBackground(.hidden)
                .background(Color.yellow)
            } else {
                // Fallback on earlier versions
            }
        }.onAppear(){
            playSong(userSong: userSong)
            detailViewPlayer.midiPlayer?.stop()
        }
    }
    
    func playSong(userSong: UserSong){
        detailViewPlayer.createMusicSequence(chords: userSong.userSong!)
        detailViewPlayer.prepareSong(musicSequence: detailViewPlayer.musicSequence!)
    }
}


