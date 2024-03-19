//
//  RemoteImageView.swift
//  STARZPLAY
//
//  Created by Usman on 16/03/2024.
//

import Foundation
import SwiftUI
struct RemoteImageView: View {
    let strURL: String
    var mode : ContentMode = .fill
    static var defaultImage = UIImage(named: "thumbnail")
    init(strURL: String,isPosterPath:Bool) {
        self.strURL = isPosterPath ? "\(Constants.APIEnvionment.imageBaseURL)w\(500)\(strURL)" : "\(Constants.APIEnvionment.imageBaseURL)w\(400)\(strURL)"
    }
    var body: some View {
        ZStack {
            AsyncImage(url: URL(string: strURL)){ image in
                image
                    .resizable()
                    .aspectRatio(contentMode: mode)
            }
            placeholder: {
                Color.gray
            }
        }
    }
}
