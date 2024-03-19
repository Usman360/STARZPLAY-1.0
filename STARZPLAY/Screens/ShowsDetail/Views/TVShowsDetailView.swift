//
//  TvShowsDetailView.swift
//  STARZPLAY
//
//  Created by Usman on 18/03/2024.
//

import SwiftUI

struct TVShowsDetailView: View {
    @StateObject private var showDetailVM: ShowDetailViewModel = ShowDetailViewModel()
    @State var isNavigate = false
    @State var selectedSeason : Int = 1
    @State  var seasonList : [SeasonsTapModel] = [SeasonsTapModel(id: 1, name: "Overview")]
    let show : Result

    var body: some View {
        ZStack{
            VStack{
                ScrollView(.vertical,showsIndicators: false){
                    DetailsTopSectionView(showsModel: show)
                    DetailView(showDetailVM: showDetailVM, isNavigate: $isNavigate,showsModel: show)
                    PagerView(selection : self.$selectedSeason, menuList: self.$seasonList)
                        .padding(.top, 30)
                    if self.showDetailVM.tvShowDetail.seasons != nil && !self.showDetailVM.tvShowDetail.seasons!.isEmpty{
                        EpisodeView(showDetailVM: self.showDetailVM, selectedSeason: self.$selectedSeason, seasonNumber: self.showDetailVM.tvShowDetail.id!)
                    }
                }
            }
            ActivityIndicatorView(showSpinner: $showDetailVM.isLoading)

        }
        .ignoresSafeArea()
        .background(Color.CUSTOMBLACK_1A1A1C)
        .task {
            showDetailVM.fetchTVShowData(showId: self.show.id ?? 219109)
        }
        .onReceive(self.showDetailVM.$seasonList) { list in
            self.seasonList =  list
        }
    }
}

#Preview {
    TVShowsDetailView(show: Result())
}

struct DetailsTopSectionView: View {
    
    @Environment (\.presentationMode) var presentationMode: Binding<PresentationMode>
    let showsModel : Result

    var body: some View {
        ZStack{
            RemoteImageView(strURL: showsModel.backdropPath ?? "", isPosterPath: true)
                .frame(width: UIScreen.main.bounds.size.width)
                .clipped()
            
            Rectangle()
                .foregroundColor(.clear)
                .background(LinearGradient(gradient: Gradient(colors: [.gray, .clear]), startPoint: .top, endPoint: .bottom))
            Rectangle()
                .foregroundColor(.clear)
                .background(LinearGradient(gradient: Gradient(colors: [Color.CUSTOMBLACK_1A1A1C, .clear]), startPoint: .bottom, endPoint: .top))

            HStack{
                Image(systemName: Constants.ImageConstants.arrowLeft)
                    .resizable()
                    .frame(width: 25, height: 20, alignment: .center)
                    .onTapGesture {
                        self.presentationMode.wrappedValue.dismiss()
                    }
                Spacer()
                Image(Constants.ImageConstants.casting)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 30, height: 30, alignment: .center)
                    .padding(.trailing,15)

                Image(systemName:Constants.ImageConstants.search)
                    .resizable()
                    .frame(width: 20, height: 20, alignment: .center)
            }
            //.bold()
            .foregroundColor(.white)
            .padding(.leading,15)
            .padding(.trailing,15)
            .padding(.bottom,130)
        }
        .frame(width: UIScreen.main.bounds.width, height: 260)
        .clipped()
    }
}

struct DetailView : View{
    
    @ObservedObject  var showDetailVM: ShowDetailViewModel
    @Binding var isNavigate : Bool
    @State private var showFullOverview = false
    let showsModel : Result
    @State var btnList = [OptionsModel(id: 1 , name: "Watchlist", image: "plus", isClicked: false),OptionsModel(id: 2 , name: "I like it", image: "hand.thumbsup", isClicked: false),OptionsModel(id: 3 , name: "I don't like it", image: "hand.thumbsdown", isClicked: false)]
   
    var body: some View {
        VStack(alignment: .leading, spacing: 8){
            HStack{
                Text(showsModel.originalName ?? "")
                    .customFont(weight: .medium, size: 25)
                    .foregroundColor(Color.white)
                Spacer()
            }
            HStack{
                Text(showsModel.firstAirDate?.getYearFromDate(showsModel.firstAirDate ?? "2017") ?? "2017")
                    .customFont(weight: .bold, size: 14)
                    .foregroundColor(.gray)
                
                Rectangle().fill(Color.gray).frame(width: 1)
                
                Text(showDetailVM.tvShowDetail.numberOfSeasons?.description ?? "")
                    .customFont(weight: .bold, size: 14)
                    .foregroundColor(.gray)
                
                Rectangle().fill(Color.gray).frame(width: 1)
                
                Text(Constants.LabelConstants.r)
                    .customFont(weight: .bold, size: 14)
                    .foregroundColor(.gray)
            }
            .frame(width: UIScreen.main.bounds.width/2, height: 12, alignment: .leading)
            HStack{
                ZStack{
                    NavigationLink(destination: VideoPlayerView(), isActive: $isNavigate){
                        Button {
                            self.isNavigate = true
                        } label: {
                            HStack{
                                Spacer()
                                Image(systemName:Constants.ImageConstants.playFill)
                                    .foregroundColor(.white)
                                    .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
                                Text(Constants.ButtonConstants.play)
                                    .customFont(weight: .semibold, size: 15)
                                    .foregroundColor(.white)
                                Spacer()
                            }
                        }
                    }
                    .frame(width: UIScreen.main.bounds.width*0.45, height: 45, alignment: .center)
                    .background(Color.CUSTOMRED_FF935B)
                    .cornerRadius(3)
                }
                Spacer()
                
                ZStack{
                    Button {
                    } label: {
                        HStack{
                            Spacer()
                            Image(systemName:Constants.ImageConstants.playRectangle)
                                .foregroundColor(.white)
                                .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
                            Text(Constants.ButtonConstants.trailer)
                                .customFont(weight: .semibold, size: 15)
                                .foregroundColor(.white)
                            Spacer()
                        }
                    }
                }
                .frame(width: UIScreen.main.bounds.width*0.45, height: 45, alignment: .center)
                .background(Color.CUSTOMBLACK_28272B)
                .cornerRadius(3)
                
            }
            
            let numberOfLines = calculateNumberOfLines(text: showDetailVM.tvShowDetail.overview ?? "")
            if let overview = showDetailVM.tvShowDetail.overview {
                Text(overview)
                    .customFont(weight: .medium, size: 12)
                    .multilineTextAlignment(.leading)
                    .foregroundColor(.gray)
                    .lineLimit(showFullOverview ? nil : 2)
                    .padding(.top, 10)
                    .background(GeometryReader { geometry in
                        Color.clear.onAppear {
                            let lines = Int(geometry.size.height / UIFont.systemFont(ofSize: 12).lineHeight)
                            showFullOverview = lines > 2
                        }
                    })
                if(numberOfLines > 2) {
                    Button(action: {
                        withAnimation {
                            showFullOverview.toggle()
                        }
                    }) {
                        Text(showFullOverview ? Constants.LabelConstants.less : Constants.LabelConstants.read)
                            .customFont(weight: .medium, size: 12)
                            .foregroundColor(Color.CUSTOMRED_FF935B)
                    }
                }
            }
            HStack(spacing:20){
                ForEach(0..<showDetailVM.btnList.count, id: \.self){ index in
                    VStack(spacing:8){
                        Button {
                            if btnList[index].id != 1{
                                var arr = btnList
                                arr  = arr.map {  obj in
                                    var obj = obj
                                    if obj.isClicked == true {
                                        obj.isClicked = false
                                    }
                                    return obj
                                }
                                arr[index].isClicked.toggle()
                                btnList = arr
                            }
                           
                        } label: {
                            ZStack{
                                Image(systemName: btnList[index].setImg)
                                    .resizable()
                                    .frame(width: 15, height: 15, alignment: .center)
                                    .foregroundColor(Color.white)
                            }
                            .frame(width: 40, height: 40, alignment: .center)
                            .background(Color.CUSTOMBLACK_28272B)
                            .clipShape(Circle())
                            
                        }
                        Text(showDetailVM.btnList[index].name)
                            .customFont(weight: .regular, size: 12)
                            .foregroundColor(.gray)
                    }
                }
                Spacer()
            }
            
        }
        .padding(10)
        
    }
    
    func calculateNumberOfLines(text: String) -> Int {
        let boundingRect = NSString(string: text)
            .boundingRect(with: CGSize(width: UIScreen.main.bounds.width - 16, height: .greatestFiniteMagnitude),
                          options: .usesLineFragmentOrigin,
                          attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)],
                          context: nil)
        let numberOfLines = Int(ceil(boundingRect.size.height / UIFont.systemFont(ofSize: 12).lineHeight))
        return numberOfLines
    }
}
