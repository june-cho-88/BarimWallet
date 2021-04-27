//
//  ReceiveView.swift
//  BarimWallet
//
//  Created by Junhyung Cho on 2021/02/13.
//

import SwiftUI

struct ReceiveView: View {
    @State private var value: Value = .init(0, representation: .bch)
    
    @State private var keyboardIsUsing: Bool = false
    
    let address: String = "qq3dqfu49efxk386pmt6mr6fyjrewudju5vyqsh5uj"
    let addressHighlightenIndex: Int = 4
    
    var body: some View {
        ZStack(alignment: .bottom) {
            List {
                Section(header: Text("Address")) {
                    Image(uiImage: QRCode(string: "bitcoincash:\(address)").uiImage)
                        .interpolation(.none)
                        .resizable()
                        .scaledToFit()
                    
                    Button(action: { UIPasteboard.general.string = "bitcoincash:" + address }) {
                        VStack(alignment: .leading, spacing: 0) {
                            Text("bitcoincash:")
                                .foregroundColor(.secondary)
                                .fontWeight(.regular)
                                .font(.system(.caption2, design: .monospaced))
                            HStack(spacing: 0) {
                                Text(address.prefix(addressHighlightenIndex))
                                    .foregroundColor(.primary)
                                    .fontWeight(.black)
                                Text(address[address.index(address.startIndex, offsetBy: addressHighlightenIndex)..<address.index(address.endIndex, offsetBy: -addressHighlightenIndex)])
                                    .foregroundColor(.secondary)
                                    .fontWeight(.semibold)
                                Text(address.suffix(addressHighlightenIndex))
                                    .foregroundColor(.primary)
                                    .fontWeight(.black)
                            }
                            .font(.system(.footnote, design: .monospaced))
                            .lineLimit(1)
                        }
                    }
                }
                
                Section(header: Text("How Much")) {
                    ValueField(maximumFontSize: 100,
                               value: $value,
                               keyboardIsUsing: $keyboardIsUsing)
                    CurrencyPicker(currency: $value.representation)
                    CounterCurrencyView(value: $value)
                }
                
                Section(header:
                            BigButton(text: "Share", height: 56) {}
                            .padding(.top)
                ) {}
                
            }
            .listStyle(InsetGroupedListStyle())
            
            HidingKeyboardBar(keyboardIsUsing: $keyboardIsUsing)
        }
        .navigationBarItems(leading:
                                Button(action: { self.value = .init(0, representation: self.value.representation) }) {
                                    Image(systemName: "arrow.clockwise")
                                }.disabled(self.value.satoshi == 0))
        .navigationTitle(Text("Receive"))
        .navigationBarTitleDisplayMode(.inline)
    }
}
