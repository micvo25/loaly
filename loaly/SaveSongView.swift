//
//  AddSongView.swift
//  loaly
//
//  Created by Salvatore D'Armetta on 7/20/24.
//

import SwiftUI

struct SaveSongView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var song: Song
    
    @State private var songName = ""
    
    var body: some View {
        NavigationView{
            Form{
                Section{
                    TextField("Name of Song", text: $songName)
                    Text("\(song.sentence)")
                }
                Section{
                    Button("Save"){
                        let newSong = UserSong(context: moc)
                        newSong.name = songName
                        newSong.userSong = song.chords
                        newSong.songText = song.sentence
                        
                        try? moc.save()
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    SaveSongView()
}
