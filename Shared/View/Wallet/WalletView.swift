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
        NavigationView {
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
        }.navigationViewStyle(StackNavigationViewStyle())
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
                VStack(alignment: .trailing) {
                    Text(showInSatoshi ? account.balance.satoshi : account.balance.bch)
                        .font(.system(.subheadline, design: .monospaced))
                    Text(showInSatoshi ? "satoshi" : "BCH")
                        .font(.system(.caption2))
                        .foregroundColor(.secondary)
                }.redacted(reason: showBalance ? .init() : .placeholder)
            }
        }
    }
}

struct AddAccountView: View {
    @Binding var presentAddAcountView: Bool
    @State private var accountName: String = ""
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    presentAddAcountView = false
                }) { Text("Cancel") }
                Spacer()
                Button(action: {
                    guard !accountName.isEmpty  else { fatalError("Account name is empty") }
                    presentAddAcountView = false
                }) { Text("Add") }
                .disabled(accountName.isEmpty)
            }.padding(.bottom)
            
            HStack {
                TextField("Account Name", text: $accountName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .foregroundColor(.blue)
                    .font(.largeTitle)
            }
            Spacer()
        }
        .padding()
    }
}
