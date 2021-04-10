//
//  HidingKeyboardLayer.swift
//  BarimWallet
//
//  Created by Junhyung Cho on 2021/04/03.
//

import SwiftUI

struct HidingKeyboardLayer: View {
    var body: some View {
        Rectangle().foregroundColor(.secondary).opacity(0.01).onTapGesture { hideKeyboard()}
    }
}
