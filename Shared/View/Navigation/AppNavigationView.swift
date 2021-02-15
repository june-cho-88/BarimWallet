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
            AppTabNavigationView()
        } else {
            // MARK: - iPad
            AppSidebarNavigationView()
        }
        #else
        // MARK: - Mac
        AppSidebarNavigationView()
        #endif
    }
    
    enum NavigationItem {
        case wallet
        case send
        case receive
        
        var string: String {
            switch self {
            case .wallet: return "Wallet"
            case .send: return "Send"
            case .receive: return "Receive"
            }
        }
        
        var sfSymbolName: String {
            switch self {
            case .wallet: return "wallet.pass"
            case .send: return "square.and.arrow.up"
            case .receive: return "square.and.arrow.down"
            }
        }
        
        @ViewBuilder var view: some View {
            switch self {
            case .wallet:
                WalletView()
            case .send:
                SendView()
            case .receive:
                ReceiveView()
            }
        }
        
        var label: some View {
            Label(self.string, systemImage: self.sfSymbolName)
        }
    }
}
