//
//  AppTabNavigationView.swift
//  BarimWallet
//
//  Created by Junhyung Cho on 2021/02/12.
//

import SwiftUI

struct AppTabNavigationView: View {
    let navigationItems: [AppNavigationView.NavigationItem] = [.send, .wallet, .receive]
    
    @State private var selection: AppNavigationView.NavigationItem = .wallet
    
    var body: some View {
        TabView(selection: $selection) {
            ForEach(navigationItems, id: \.self) { item in
                NavigationView { item.view }
                    .navigationViewStyle(StackNavigationViewStyle())
                    .tabItem { item.label }
                    .tag(item)
            }
            
        }
    }
}
