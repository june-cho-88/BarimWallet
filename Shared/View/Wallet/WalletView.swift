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
    @State private var selectedCurrency: Value.Representation = .bch
    
    @State private var presentAddAcountView: Bool = false
    
    var body: some View {
        List {
            ForEach(wallet.accounts) {
                WalletListRowView(account: $0,
                                  showBalance: $showBalance,
                                  selectedCurrency: $selectedCurrency)
            }
        }
        .listStyle(DefaultListStyle())
        .navigationTitle("Wallet")
        .navigationBarItems(leading:
                                HStack {
                                    Button(action: { showBalance.toggle() }) {
                                        Image(systemName: (showBalance ? "eye.fill" : "eye"))
                                    }
                                    .disabled(wallet.accounts.isEmpty)
                                    
                                    Button(action: { selectedCurrency.toggle() }) {
                                        Image(systemName: selectedCurrency.buttonImageName)
                                    }
                                    .disabled(!showBalance).opacity(showBalance ? 1.0 : 0.0)
                                },
                            trailing:
                                Button(action: { presentAddAcountView = true }) {
                                    Image(systemName: "plus")
                                }
                                .sheet(isPresented: $presentAddAcountView) {
                                    AddAccountView(presentAddAcountView: $presentAddAcountView)
                                }
        )
    }
}

struct WalletListRowView: View {
    let account: Account
    
    @Binding var showBalance: Bool
    @Binding var selectedCurrency: Value.Representation
    
    var body: some View {
        NavigationLink(destination: AccountView(account: account,
                                                showBalance: $showBalance,
                                                selectedCurrency: $selectedCurrency)) {
            HStack {
                Text(account.name)
                    //.font(.system(.title3))
                if account.lock {
                    Image(systemName: "lock.fill")
                        .font(.system(.footnote))
                        .foregroundColor(.accentColor)
                }
                Spacer()
                ValueView(direction: .vertical,
                          size: .small,
                          value: .init(account.balance, representation: selectedCurrency))
                    .redacted(reason: showBalance ? .init() : .placeholder)
            }
        }
    }
}
