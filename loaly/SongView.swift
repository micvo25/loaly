//
//  SongView.swift
//  loaly
//
//  Created by Salvatore D'Armetta on 1/23/24.
//

import SwiftUI

struct SongView: View {
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
                           Button(action: {}, label: {
                               Image(systemName: "play.fill")
                                   .resizable()
                                   .scaledToFit()
                                   .frame(width: 25, height: 25)
                                   .accentColor(.black)
                           })
                           Button(action: {}, label: {
                               Image(systemName: "square.and.arrow.up")
                                   .resizable()
                                   .scaledToFit()
                                   .frame(width: 30, height: 30)
                                   .accentColor(.black)
                           })
                       }
                       Spacer()
                   }
               }
               
               
               
               
           }
       }

       #Preview {
           SongView()
       }
