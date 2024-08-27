//
//  loalyApp.swift
//  loaly
//
//  Created by Salvatore D'Armetta on 1/23/24.
//

import SwiftUI

@main
struct loalyApp: App {
    
    @StateObject private var dataController = DataController()
    @StateObject var song = Song()
    @ObservedObject var player = MidiPlayer()
    @ObservedObject var detailViewPlayer = MidiPlayer()
    
    var body: some Scene {
        WindowGroup {
            ContentView(player: player, detailViewPlayer: detailViewPlayer)
                .environment(\.managedObjectContext, dataController.container.viewContext)
                .environmentObject(song)
        }
    }
}
