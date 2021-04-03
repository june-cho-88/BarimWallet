//
//  Color+.swift
//  BarimWallet
//
//  Created by Junhyung Cho on 2021/03/30.
//

import SwiftUI

extension Color {
    static func bitcoin(_ color: BitcoinDotCom) -> Color {
        color.color
    }
    
    enum BitcoinDotCom {
        case green, black, white, blue, purple, navy, gold, yellow, red, pink
        
        var color: Color {
            switch self {
            case .green:
                return Color(red: 0.039, green: 0.757, blue: 0.557, opacity: 1.000)
            case .black:
                return Color(red: 0.075, green: 0.090, blue: 0.125, opacity: 1.000)
            case .white:
                return Color(red: 0.984, green: 0.988, blue: 1.000, opacity: 1.000)
            case .blue:
                return Color(red: 0.184, green: 0.663, blue: 0.933, opacity: 1.000)
            case .purple:
                return Color(red: 0.424, green: 0.263, blue: 0.933, opacity: 1.000)
            case .navy:
                return Color(red: 0.161, green: 0.200, blue: 0.737, opacity: 1.000)
            case .gold:
                return Color(red: 0.941, green: 0.620, blue: 0.055, opacity: 1.000)
            case .yellow:
                return Color(red: 0.929, green: 0.718, blue: 0.180, opacity: 1.000)
            case .red:
                return Color(red: 0.886, green: 0.247, blue: 0.180, opacity: 1.000)
            case .pink:
                return Color(red: 0.933, green: 0.216, blue: 0.447, opacity: 1.000)
            }
        }
    }
}
