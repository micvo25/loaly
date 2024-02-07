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
    
    @EnvironmentObject var audioPlayerViewModel: AudioPlayerViewModel
    @State private var showingExporter = false
    @State private var timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    @State var showShareSheet = false
    
    var body: some View {
        ZStack{
                   Color.yellow
                       .ignoresSafeArea()
                       .onReceive(timer, perform: { _ in
                           if let currentTime = audioPlayerViewModel.audioPlayer?.currentTime {
                               // reset playValue, so reset isPlaying if needed
                               if currentTime == TimeInterval(0.0) { // only explicitly
                                  audioPlayerViewModel.isPlaying = false
                               }
                           }
                       })
            
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
                           Button(action: {
                               showShareSheet = true
                           }, label: {
                               Image(systemName: "square.and.arrow.up.fill")
                                   .accentColor(.black)
                                   .imageScale(.large)
                           })
                       }
                       .sheet(isPresented: $showShareSheet, content: {
                           ActivityViewController(itemsToShare: getComposition())
                       })
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
           SongView()
       }
