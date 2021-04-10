//
//  AccountPicker.swift
//  BarimWallet
//
//  Created by Junhyung Cho on 2021/04/03.
//

import SwiftUI

struct AccountPicker: View {
    @Binding var account: Account
    @State private var selectedCurrency: Value.Representation = .bch
    
    var body: some View {
        Picker(selection: $account,
               label:
                HStack {
                    Text("\(account.name)")
                        .font(.system(.headline))
                    Spacer()
                    ValueView(direction: .horizontal,
                              size: .small,
                              value: .init(account.balance, representation: selectedCurrency))
                }
        ) {
            ForEach(Wallet.sample.accounts) { account in
                Text("\(account.name)").tag(account)
            }
        }
        .pickerStyle(MenuPickerStyle())
    }
}
