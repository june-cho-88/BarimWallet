//
//  WalletView.swift
//  BarimWallet
//
//  Created by Junhyung Cho on 2021/02/13.
//

import SwiftUI

struct WalletView: View {
    let wallet: Wallet
    
    @State private var showBalance: Bool = true
    @State private var showInSatoshi: Bool = false
    @State private var presentAddAcountView: Bool = false
    
    var body: some View {
        List {
            ForEach(wallet.accounts) {
                WalletListRowView(account: $0,
                                  showBalance: $showBalance,
                                  showInSatoshi: $showInSatoshi)
            }
        }
        .listStyle(DefaultListStyle())
        .navigationTitle("Wallet")
        .navigationBarItems(leading:
                                HStack {
                                    Button(action: { showBalance.toggle() }) {
                                        Image(systemName: (showBalance ? "eye.fill" : "eye"))
                                    }.disabled(wallet.accounts.isEmpty)
                                    Button(action: { showInSatoshi.toggle() }) {
                                        Image(systemName: (showInSatoshi ? "s.circle" : "bitcoinsign.circle.fill"))
                                    }.disabled(!showBalance).opacity(showBalance ? 1.0 : 0.0)
                                },
                            trailing:
                                Button(action: { presentAddAcountView = true }) {
                                    Image(systemName: "plus")
                                }.sheet(isPresented: $presentAddAcountView) { AddAccountView(presentAddAcountView: $presentAddAcountView) } )
    }
}

struct WalletListRowView: View {
    let account: Account
    
    @Binding var showBalance: Bool
    @Binding var showInSatoshi: Bool
    
    var body: some View {
        NavigationLink(destination: AccountView(account: account,
                                                showBalance: $showBalance,
                                                showInSatoshi: $showInSatoshi)) {
            HStack {
                Text(account.name)
                Spacer()
                ValueView(showInSatoshi: $showInSatoshi,
                          direction: .vertical,
                          size: .small,
                          balance: account.balance)
                    .redacted(reason: showBalance ? .init() : .placeholder)
            }
        }
    }
}
