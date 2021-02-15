//
//  WalletView.swift
//  BarimWallet
//
//  Created by Junhyung Cho on 2021/02/13.
//

import SwiftUI

struct WalletView: View {
    @State private var showBalance: Bool = false
    @State private var presentAddAcountView: Bool = false
    
    var body: some View {
        NavigationView {
            List {
                WalletListRowView(showBalance: $showBalance)
            }
            .listStyle(DefaultListStyle())
            .navigationTitle("Wallet")
            .navigationBarItems(leading:
                                    Button(action: { showBalance.toggle() }) {
                                        Image(systemName: (showBalance ? "eye.fill" : "eye"))
                                    }.disabled(true),
                                trailing:
                                    Button(action: { presentAddAcountView = true }) {
                                        Image(systemName: "plus")
                                    }.sheet(isPresented: $presentAddAcountView) { AddAccountView(presentAddAcountView: $presentAddAcountView) }
            )
        }
    }
}

struct WalletListRowView: View {
    @Binding var showBalance: Bool
    
    var body: some View {
        NavigationLink(destination: AccountView()) {
            HStack {
                Text("My Account")
                Spacer()
                VStack(alignment: .trailing) {
                    Text("Balance")
                        .font(.system(.subheadline, design: .monospaced))
                    Text("BCH")
                        .font(.system(.caption2))
                        .foregroundColor(.secondary)
                }.redacted(reason: showBalance ? .init() : .placeholder)
            }
        }
    }
}

struct AddAccountView: View {
    @Binding var presentAddAcountView: Bool
    @State private var accountName = ""
    
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
