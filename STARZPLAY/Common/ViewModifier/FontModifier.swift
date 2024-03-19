//
//  FontModifier.swift
//  STARZPLAY
//
//  Created by Usman on 15/03/2024.
//

import SwiftUI

struct FontModifier: ViewModifier {
    var weight: Font.Weight
    var size: CGFloat

    func body(content: Content) -> some View {
        switch weight {
        case .bold:
            return content.font(.custom("Montserrat-Bold", size: size))
        case .medium:
            return content.font(.custom("Montserrat-Medium", size: size))
        case .regular:
            return content.font(.custom("Montserrat-Regular", size: size))
        case .semibold:
            return content.font(.custom("Montserrat-SemiBold", size: size))
        default:
            return content.font(.custom("Montserrat-Regular", size: size))
        }
    }
}

