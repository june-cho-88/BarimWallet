//
//  BigButton.swift
//  BarimWallet
//
//  Created by Junhyung Cho on 2021/04/03.
//

import SwiftUI

struct BigButton: View {
    let text: String
    let height: CGFloat
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            RoundedRectangle(cornerRadius: height/3, style: .continuous)
                .frame(height: height)
                .shadow(color: Color.secondary.opacity(0.5), radius: 3, x: 0, y: 0)
                .overlay(Text(text).foregroundColor(.white).font(.system(.title2)))
        }
    }
}
