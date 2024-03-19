//
//  AllExtensions.swift
//  STARZPLAY
//
//  Created by Usman on 15/03/2024.
//

import SwiftUI
// MARK: - Views
extension View {
    func customFont(weight: Font.Weight, size: CGFloat) -> some View {
        return self.modifier(FontModifier(weight: weight, size: size))
    }
   
}
// MARK: - Colors

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

extension Color {
    static let CUSTOMBLACK_1A1A1C = Color("black_1A1A1C")
    static let CUSTOMBLACK_28272B = Color("black_28272B")
    static let CUSTOMRED_FF935B = Color("red_FF935B")
}

// MARK: - String
extension String {
    
    var toDate : Date {
        let dateString : String = self
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT+0:00")
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from:dateString) ?? Date()
        return date
    }
    
    
    func getYearFromDate(_ date:String) -> String? {
        let formatter  = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        guard let todayDate = formatter.date(from: date) else { return nil }
        let myCalendar = Calendar(identifier: .gregorian)
        let year = myCalendar.component(.year, from: todayDate)
        return "\(year)"
    }
}
