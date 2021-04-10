//
//  HidingKeyboardBar.swift
//  BarimWallet
//
//  Created by Junhyung Cho on 2021/04/05.
//

import SwiftUI

struct HidingKeyboardBar: View {
    @Binding var keyboardIsUsing: Bool
    
    var body: some View {
        if keyboardIsUsing {
            HStack {
                Spacer()
                Button(action: {
                    hideKeyboard()
                    keyboardIsUsing = false
                }) {
                    Image(systemName: "keyboard.chevron.compact.down")
                }
            }
            .padding()
            .background(Color.primary.colorInvert().opacity(0.9))
        }
    }
}
