//
//  TransactionView.swift
//  BarimWallet
//
//  Created by Junhyung Cho on 2021/02/21.
//

import SwiftUI

struct TransactionView: View {
    @State private var inputOrOutputSelector: Transaction.Kind = .input
    
    var body: some View {
        List {
            Section(header: Text("Amount")) {
                HStack {
                    switch Bool.random() {
                    case true:
                        Image(systemName: "plus.square.fill")
                            .foregroundColor(.blue)
                    case false:
                        Image(systemName: "minus.square.fill")
                            .foregroundColor(.red)
                    }
                    HStack(alignment: .bottom, spacing: 3) {
                        Text(String(format: "%.8f", Double(UInt.random(in: 0 ... 100_00000000)) / 100_000_000))
                            .font(.system(.subheadline, design: .monospaced))
                        Text("BCH")
                            .font(.system(.caption))
                            .foregroundColor(.secondary)
                    }
                }
                HStack {
                    Image(systemName: "f.square")
                    HStack(alignment: .bottom, spacing: 3) {
                        Text(String(format: "%.0f", Double(UInt.random(in: 0 ... 0_00001000))))
                            .font(.system(.subheadline, design: .monospaced))
                        Text("satoshis")
                            .font(.system(.caption))
                    }
                    Spacer()
                    HStack {
                        Image(systemName: "gauge")
                        Text("1 satoshi / byte")
                    }
                    .font(.footnote)
                }
                .foregroundColor(.secondary)
            }
            Section(header: Text("Date")) {
                HStack {
                    VStack(alignment: .leading) {
                        HStack {
                            Image(systemName: "antenna.radiowaves.left.and.right")
                            Text("Broadcasted")
                        }
                        .font(.caption)
                        .foregroundColor(.secondary)
                        Text("2020-09-01 23:55:55")
                            .font(.subheadline)
                    }
                    Spacer()
                    VStack(alignment: .leading) {
                        HStack {
                            Image(systemName: "checkmark.square")
                            Text("Confirmed")
                        }
                        .font(.caption)
                        .foregroundColor(.secondary)
                        Text("2020-09-01 23:50:33")
                            .font(.subheadline)
                            .fontWeight(.medium)
                    }
                }
            }.lineLimit(1)
            Section(header:
                        Picker(selection: $inputOrOutputSelector, label: Text("InputOrOutputPicker")) {
                            Text("3 Inputs").tag(Transaction.Kind.input)
                            Text("1 Output").tag(Transaction.Kind.output)
                        }.pickerStyle(SegmentedPickerStyle())) {
                ForEach(1...1, id: \.self) { index in
                    NavigationLink(destination: Text("address")) {
                        Text("bitcoincashaddresswillbeonthisline12345678890")
                    }
                }
            }.lineLimit(1)
        }
        .listStyle(GroupedListStyle())
        .navigationTitle("Transaction")
    }
}
