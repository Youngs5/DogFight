//
//  Color+Extension.swift
//  DogFight
//
//  Created by 방유빈 on 2023/09/15.
//

import Foundation
import SwiftUI

public extension Color {
    init(hex: String, opacity: Double = 1.0) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        
        var rgb: UInt64 = 0
        
        Scanner(string: hexSanitized).scanHexInt64(&rgb)
        
        let red = Double((rgb & 0xFF0000) >> 16) / 255.0
        let green = Double((rgb & 0x00FF00) >> 8) / 255.0
        let blue = Double(rgb & 0x0000FF) / 255.0
        
        self.init(red: red, green: green, blue: blue, opacity: opacity)
    }
    
    static let backgrounBlack = Color(hex: "#1F2022")
    static let fieldGrayColor = Color(hex: "#35373D")
    static let listGrayColor = Color(hex: "#2A2B2F")
    static let signInWhite = Color(hex: "#F4F4F4")
}

