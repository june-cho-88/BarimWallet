//
//  View+.swift
//  BarimWallet
//
//  Created by Junhyung Cho on 2021/03/30.
//

import SwiftUI

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif
