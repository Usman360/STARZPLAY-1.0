//
//  Constants.swift
//  STARZPLAY
//
//  Created by Usman on 16/03/2024.
//

import Foundation

struct Constants {
    
    struct APIEnvionment {
        static var cloudinaryBaseUrl: URL {
            URL(string: "https://res.cloudinary.com/cocoacasts/image/fetch/")!
        }
        
        static var apiBaseURL: String {
            "https://api.themoviedb.org/3/tv/"
        }
        static var imageBaseURL: String {
            "https://image.tmdb.org/t/p/"
        }
        
        static var apiKey: String {
            "ecef14eac236a5d4ec6ac3a4a4761e8f"
        }
    }
    struct ButtonConstants{
        static let play = "Play"
        static let trailer = "Trailer"
    }
    struct LabelConstants{
        static let read = "Read More"
        static let less = "Read Less"
        static let r = "R"
    }
    struct ImageConstants{
        static let arrowLeft = "arrow.left"
        static let search = "magnifyingglass"
        static let playFill = "play.fill"
        static let playRectangle = "play.rectangle"
        static let arrowRight = "chevron.right"
        static let arrowDown = "arrow.down.to.line"
        static let goBack10Sec = "gobackward.10"
        static let pauseFill = "pause.fill"
        static let goForward10Sec = "goforward.10"
        static let logo = "starzplay"
        static let casting = "chromecast"
    }
    
    struct videoURL{
        static let url = "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4"
    }
}
