//
//  ActivityIndicatorView.swift
//  STARZPLAY
//
//  Created by Usman on 19/03/2024.
//

import SwiftUI

struct ActivityIndicatorView: View {
    // MARK: - Properties
    @Binding  var showSpinner : Bool
    @State private var degree:Int = 270
    @State private var spinnerLength = 0.6
    
    // MARK: - Body

    var body: some View {
        if showSpinner{
            Circle()
                .trim(from: 0.0,to: spinnerLength)
                .stroke(LinearGradient(colors: [.red,.black], startPoint: .leading, endPoint: .trailing),style: StrokeStyle(lineWidth: 8.0,lineCap: .round,lineJoin:.round))
                .frame(width: 60,height: 60)
                .rotationEffect(Angle(degrees: Double(degree)))
                .onAppear{
                    
                    withAnimation(Animation.linear(duration: 1).repeatForever(autoreverses: false)){
                        degree = 270 + 360
                    }
                    withAnimation(Animation.easeIn(duration: 1.5).repeatForever(autoreverses: true)){
                        spinnerLength = 0
                    }
                    
                    
                }
        }
    }
}

#Preview {
    ActivityIndicatorView(showSpinner: .constant(false))
}
