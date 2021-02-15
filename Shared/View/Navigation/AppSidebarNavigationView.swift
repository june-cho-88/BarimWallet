//
//  AppSidebarNavigationView.swift
//  BarimWallet
//
//  Created by Junhyung Cho on 2021/02/12.
//

import SwiftUI

struct AppSidebarNavigationView: View {
    let navigationItems: [AppNavigationView.NavigationItem] = [.wallet, .send, .receive]
    
    @State private var selection: AppNavigationView.NavigationItem! = .wallet
    
    var body: some View {
        NavigationView {
            sidebar
                .navigationTitle("Barim")
            noSelection
        }
    }
    
    var sidebar: some View {
        List {
            ForEach(navigationItems, id: \.self) { item in
                NavigationLink(destination: item.view,
                               tag: item,
                               selection: $selection) {
                    item.label
                }
            }
        }.listStyle(SidebarListStyle())
    }
    
    var noSelection: some View {
        Text("No selection")
            .foregroundColor(.secondary)
    }
}
