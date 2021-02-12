//
//  AppNavigationView.swift
//  BarimWallet
//
//  Created by Junhyung Cho on 2021/02/12.
//

import SwiftUI

struct AppNavigationView: View {
    #if os(iOS)
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    #endif
    var body: some View {
        #if os(iOS)
        if horizontalSizeClass == .compact {
            // MARK: - iPhone
            Text("iPhone")
        } else {
            // MARK: - iPad
            Text("iPad")
        }
        #else
        // MARK: - Mac
        Text("Mac")
        #endif
    }
}
