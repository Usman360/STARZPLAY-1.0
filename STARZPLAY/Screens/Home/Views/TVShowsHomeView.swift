//
//  TVShowsHomeView.swift
//  STARZPLAY
//
//  Created by Usman on 15/03/2024.
//

import SwiftUI

struct TVShowsHomeView: View {
    @StateObject var viewModel = TVShowsHomeViewModel()
    
    
    var body: some View {
        NavigationView {
            ZStack{
                ScrollView(.vertical, showsIndicators: false){
                    LazyVStack(alignment:.leading){
                        ShowsSliderView(topShows: viewModel.toptvShows)
                        ForEach(0..<viewModel.arrSections.count, id: \.self){ index in
                            VStack(alignment:.leading,spacing: 0){
                                SectionHeaderView(title: viewModel.arrSections[index].rawValue)
                                ScrollView(.horizontal,showsIndicators: false){
                                    HStack(spacing:12){
                                        ForEach(0..<viewModel.tvShows.count, id: \.self){ index in
                                            NavigationLink(destination: TVShowsDetailView(show:viewModel.tvShows[index]).navigationBarBackButtonHidden()){
                                                ShowsView(showsModel: viewModel.tvShows[index])
                                            }
                                        }
                                    }
                                    .padding(EdgeInsets(top: 0, leading: 15, bottom: 15, trailing: 15))
                                }
                            }
                        }
                    }
                }
                
            }
            .background(LinearGradient(gradient: Gradient(colors: [Color.gray, Color.black]), startPoint: .top, endPoint: .bottom))
            .preferredColorScheme(.dark)
            .task {
                viewModel.fetchTVShowData(page: 1)
            }
            .toolbar {
                ToolbarItem(placement: .navigation) {
                    LogoView()
                        .padding(.leading,-17)
                        
                }
            }
        }
        
    }
}

#Preview {
    TVShowsHomeView()
}

struct ShowsSliderView: View {
    
    let topShows : [Result]
    @State var selectedIndex : Int = 0
    
    var body: some View {
        ZStack(alignment: .bottomLeading){
            TabView(selection: self.$selectedIndex){
                
                ForEach(0..<topShows.count, id: \.self){ index in
                    NavigationLink(destination: TVShowsDetailView(show:topShows[index]).navigationBarBackButtonHidden()) {
                        
                        ZStack(alignment: .bottomLeading){
                            RemoteImageView(strURL: topShows[index].backdropPath ?? "", isPosterPath: false)
                                .frame(width: UIScreen.main.bounds.size.width)
                                .clipped()
                            Rectangle()
                                .foregroundColor(.clear)
                                .background(LinearGradient(gradient: Gradient(colors: [.clear, .black]), startPoint: .top, endPoint: .bottom))
                            Text(topShows[index].name ?? "")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundStyle(Color.white)
                                .multilineTextAlignment(.leading)
                                .padding(15)
                                .padding(.leading,15)
                                .padding(.bottom,15)
                                .padding(.trailing,15)

                        }
                        .frame(width: UIScreen.main.bounds.size.width - 35)
                        .cornerRadius(14)
                        .clipped()
                        
                    }
                }
                
            }
            .frame(height: 500)
            .tabViewStyle(PageTabViewStyle())
            
            
        }
        .overlay(
            RoundedRectangle(cornerRadius: 14)
                .stroke(.gray, lineWidth: 2)
                
        )
        
        .padding([.leading,.trailing],17)
        
    }
}


struct LogoView: View {
    var body: some View {
        HStack{
            Image(Constants.ImageConstants.logo)
                .resizable()
                .overlay(
                    LinearGradient(gradient:
                                    Gradient(
                                        colors: [.red, .black]),
                                   startPoint: .topLeading,
                                   endPoint: .bottomTrailing)
                    .mask(Image(Constants.ImageConstants.logo)
                        .resizable()
                        .frame(width: 200, height: 200))
                )
                .frame(width: 200, height: 200)
            Spacer()
        }
        .frame(height: 50)
    }
}



struct SectionHeaderView: View {
    
    let title : String
    var body: some View {
        Text(title)
            .font(.title)
            .fontWeight(.bold)
            .foregroundStyle(Color.white)
            .padding(15)

    }
}

struct ShowsView: View {
    let showsModel : Result
    var body: some View {
        RemoteImageView(strURL: showsModel.posterPath ?? "", isPosterPath: false)
            .frame(width: 150, height: 200)
            .cornerRadius(8)
    }
}
