//
//  ValueInputView.swift
//  BarimWallet
//
//  Created by Junhyung Cho on 2021/03/29.
//

import SwiftUI

struct ValueInputView: View {
    @Binding var value: String
    
    let digit: Digit
    
    var body: some View {
        TextField(digit.description, text: $value)
            .multilineTextAlignment(digit.alignment)
            .font(digit.font)
    }
}

extension ValueInputView {
    enum Digit: CustomStringConvertible {
        case bch, satoshi
        
        var description: String {
            switch self {
            case .bch: return "BCH"
            case .satoshi: return "satoshi"
            }
        }
        
        var alignment: TextAlignment {
            switch self {
            case .bch: return .trailing
            case .satoshi: return .leading
            }
        }
        
        var font: Font {
            switch self {
            case .bch: return .system(.largeTitle, design: .monospaced)
            case .satoshi: return .system(.title, design: .monospaced)
            }
        }
    }
}
