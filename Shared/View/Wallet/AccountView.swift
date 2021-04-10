//
//  AccountView.swift
//  BarimWallet
//
//  Created by Junhyung Cho on 2021/02/16.
//

import SwiftUI

struct AccountView: View {
    let account: Account
    
    @Binding var showBalance: Bool
    @Binding var selectedCurrency: Value.Representation
    @State private var weekly: Bool = true
    
    var body: some View {
        List {
            Section(header: Text("Balance")) {
                balanceRow
            }
            
            Section(header: Text("Activity")) {
                ChartView()
                    .frame(height: 115)
            }
            
            Section(header: Text("Transaction")) {
                //ForEach(account.transactions.sorted()) {}
                ForEach(0...99, id: \.self) { _ in
                    NavigationLink(destination: TransactionView(selectedCurrency: $selectedCurrency)) {
                        transactionRow
                    }
                }
            }
        }
        .listStyle(GroupedListStyle())
        .navigationTitle(Text(account.name))
        .navigationBarItems(trailing:
                                Button(action: { showBalance.toggle() }) {
                                    Image(systemName: (showBalance ? "eye.fill" : "eye"))
                                }
        )
    }
    
    var balanceRow: some View {
        HStack {
            ValueView(direction: .horizontal,
                      size: .small,
                      value: .init(account.balance, representation: selectedCurrency))
                .redacted(reason: showBalance ? .init() : .placeholder)
            
            Spacer()
            
            Button(action: { selectedCurrency.toggle() }) {
                Image(systemName: selectedCurrency.buttonImageName)
            }
            .disabled(!showBalance).opacity(showBalance ? 1.0 : 0.0)
            .buttonStyle(BorderlessButtonStyle())
        }
    }
    
    var transactionRow: some View {
        HStack {
            switch Bool.random() {
            case true:
                Image(systemName: "plus.square")
                    .foregroundColor(.blue)
                    .font(.title2)
            case false:
                Image(systemName: "minus.square")
                    .foregroundColor(.red)
                    .font(.title2)
            }
            VStack(alignment: .leading, spacing: 3) {
                Text("Yesterday")
                    .font(.headline)
                Text("3 confirmations")
                    .font(.footnote)
                    .foregroundColor(.secondary)
            }
            Spacer()
            VStack(alignment: .trailing) {
                Text(account.getBalance(in: selectedCurrency))
                    .font(.system(.subheadline, design: .monospaced))
                Text(selectedCurrency.description)
                    .font(.system(.caption2))
                    .foregroundColor(.secondary)
            }.redacted(reason: showBalance ? .init() : .placeholder)
        }.lineLimit(1)
    }
}

struct ChartView: View {
    var body: some View {
        HStack {
            ForEach((0..<7).reversed(), id: \.self) { index in
                VStack(spacing: 2) {
                    Spacer()
                    ChartBarView(height: CGFloat.random(in: 0.0 ... 1.0),
                                 colors: [.yellow, .green, .blue])
                        .padding(.horizontal, 5)
                    Text(index.description)
                        .foregroundColor(.secondary)
                        .font(.caption2)
                        .lineLimit(1)
                }
            }
        }
    }
}

struct ChartBarView: View {
    let radius: CGFloat = 5
    let height: CGFloat
    let colors: [Color]
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .bottom) {
                RoundedRectangle(cornerRadius: radius, style: .continuous).opacity(0.1)
                    .foregroundColor(.secondary)
                
                RoundedRectangle(cornerRadius: radius, style: .continuous)
                    .fill(LinearGradient(gradient: Gradient(colors: colors),
                                         startPoint: .topLeading,
                                         endPoint: .bottomTrailing))
                    .frame(height: geometry.size.height * height)
            }
        }
    }
}
