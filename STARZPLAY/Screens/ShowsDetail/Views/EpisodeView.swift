//
//  EpisodeView.swift
//  STARZPLAY
//
//  Created by Usman on 18/03/2024.
//

import SwiftUI

struct EpisodeView: View {
    @ObservedObject var showDetailVM: ShowDetailViewModel
    @Binding var selectedSeason : Int
    let seasonNumber : Int
    @State private var isClicked: Bool = false

    var body: some View {
        
        return ZStack{
            
            LazyVStack(spacing: 5){
                if (self.showDetailVM.seasonDetail.episodes != nil && !self.showDetailVM.seasonDetail.episodes!.isEmpty){
                    ForEach (self.showDetailVM.seasonDetail.episodes!, id: \.id){ episode in
                        HStack{
                            Group{
                                Image(systemName: Constants.ImageConstants.arrowRight)
                                    .resizable()
                                    .tint(.white)
                                    .frame(width: 10, height: 15)
                                    .padding(.leading,15)
                                
                                ZStack{
                                    RemoteImageView(strURL: episode.stillPath ?? "", isPosterPath: false)
                                        .frame(width:150, height: 80)
                                    
                                    ZStack{
                                        Image(systemName:Constants.ImageConstants.playFill)
                                            .foregroundColor(.white)
                                            .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
                                    }
                                    .frame(width: 30, height: 30)
                                    .background(Color.black.opacity(0.4))
                                    .clipShape(Circle())
                                }
                                .padding(.leading, 10)
                                
                            }
                            Group{
                                
                                VStack(alignment: .leading){
                                    Spacer()
                                    Text("E\(episode.episodeNumber ?? 0) - \(episode.name ?? "")")
                                        .customFont(weight: .regular, size: 12)
                                        .multilineTextAlignment(.leading)
                                        .foregroundColor(.white)
                                    Spacer()
                                }
                                
                                Spacer()
                                
                                Image(systemName:Constants.ImageConstants.arrowDown)
                                    .resizable()
                                    .frame(width: 15, height: 20)
                                    .tint(.white)
                                    .padding(.trailing,20)
                            }
                            
                        }
                        .onTapGesture {
                            isClicked = true
                        }
                        .background(NavigationLink("", destination: VideoPlayerView(), isActive: $isClicked))
                        .frame(width: UIScreen.main.bounds.width, height: 120, alignment: .center)
                        .background(Color("dark_gray_color"))
                    }
                    
                }
                else{
                    EmptyView()
                }
            }
            GeometryReader { proxy -> AnyView in
                if (self.showDetailVM.isAlreadySelected){
                    self.showDetailVM.fetchSeasonData(self.seasonNumber, self.selectedSeason)
                }
                
                return AnyView(EmptyView())
            }
            .background(NavigationLink("", destination: VideoPlayerView(), isActive: $isClicked))
            .onChange(of: self.selectedSeason) { change in
                self.showDetailVM.isAlreadySelected = true
            }
        }
    }
}
