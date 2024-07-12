//
//  loalyApp.swift
//  loaly
//
//  Created by Salvatore D'Armetta on 1/23/24.
//

import SwiftUI

@main
struct loalyApp: App {
    
    @StateObject var song = Song()
    @StateObject var player = MidiPlayer()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(song)
                .environmentObject(player)
        }
    }
}
