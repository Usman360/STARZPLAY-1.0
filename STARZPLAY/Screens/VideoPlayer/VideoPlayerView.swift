//
//  VideoPlayerView.swift
//  STARZPLAY
//
//  Created by Usman on 18/03/2024.
//

import SwiftUI

import AVKit

struct VideoPlayerView: View {
    
    @State var player = AVPlayer(url: URL(string: Constants.videoURL.url)!)
    
    var body: some View {
            VStack{
                VideoPlayer(player:player)
                    .frame(height: 400)
                    .cornerRadius(12)
                    .padding([.leading,.trailing],15)
                Text("Starzplay")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundStyle(Color.black)
                    .multilineTextAlignment(.leading)
                    .padding(15)

            }
            .frame(width: UIScreen.main.bounds.size.width,height: UIScreen.main.bounds.size.height)
            .background(.white)
            .onAppear {
                self.player.play()
            }
            .onDisappear {
                self.player.pause()
            }

    }
}



