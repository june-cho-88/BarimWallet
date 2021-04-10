//
//  SendView.swift
//  BarimWallet
//
//  Created by Junhyung Cho on 2021/02/13.
//

import SwiftUI

struct SendView: View {
    @State private var selectedAccount: Account = Wallet.sample.accounts.first!
    
    @State private var value: Value = .init(0, representation: .bch)
    @State private var displayAddress: String = ""
    
    @State private var isSendable: Bool = true
    @State private var keyboardIsUsing: Bool = false
    @State private var presentQRCodeScannerView: Bool = false
    
    var body: some View {
        ZStack(alignment: .bottom) {
            List {
                Section(header: Text("From")) {
                    AccountPicker(account: $selectedAccount)
                }
                
                Section(header: Text("How Much")) {
                    ValueField(maximumFontSize: 100,
                               value: $value,
                               keyboardIsUsing: $keyboardIsUsing)
                    CurrencyPicker(currency: $value.representation)
                    CounterCurrencyView(value: $value)
                }
                
                Section(header: Text("To")) {
                    AddressField(address: $displayAddress,
                                 keyboardIsUsing: $keyboardIsUsing,
                                 presentQRCodeScannerView: $presentQRCodeScannerView)
                }
                
                Section(header:
                            BigButton(text: "Send", height: 56) {}
                            .padding(.top),
                        footer:
                            HStack(alignment: .firstTextBaseline, spacing: 0) {
                                Spacer()
                                Text("Fee: ")
                                    .foregroundColor(.secondary)
                                    .font(.system(.caption))
                                Group {
                                    Text("3")
                                        .fontWeight(.bold)
                                    Text(" KRW")
                                }
                                .foregroundColor(.primary)
                                .font(.system(.footnote))
                            }
                ) {}
            }
            .listStyle(InsetGroupedListStyle())
            
            HidingKeyboardBar(keyboardIsUsing: $keyboardIsUsing)
        }
        .navigationBarItems(leading:
                                Button(action: { self.value.displayNumber = ""; self.displayAddress = "" }) {
                                    Image(systemName: "trash")
                                }.disabled(self.value.displayNumber == "" && self.displayAddress == ""))
        .navigationTitle(Text("Send"))
        .navigationBarTitleDisplayMode(.inline)
    }
    
    var numberPadView: some View {
        Text("NumberPad")
        //        GeometryReader { geometry in
        //
        //            VStack {
        //                Spacer()
        //                HStack(alignment: .bottom) {
        //                    Rectangle().frame(width: geometry.size.width/33).opacity(0)
        //                    VStack(spacing: 0) {
        //
        //
        //                        Text(displayValue)
        //                            .lineLimit(1)
        //                            .font(.system(size: 100, weight: .black, design: .monospaced)).minimumScaleFactor(0.1)
        //                            .foregroundColor(.primary)
        //
        //
        //                        Picker(selection: $selectedCurrency, label: Text(selectedCurrency.description)) {
        //                            Text(Value.Representation.bch.description).tag(Value.Representation.bch)
        //                            Text(Value.Representation.fiat(.krw).description).tag(Value.Representation.fiat(.krw))
        //                        }.pickerStyle(SegmentedPickerStyle())
        //                    }
        //                    Rectangle().frame(width: geometry.size.width/33).opacity(0)
        //                }
        //
        //
        //
        //                NumberPad(value: $displayValue)
        //                    .frame(height: geometry.size.height / 2)
        //                    .padding()
        //
        //
        //
        //                Picker(selection: $selectedAccount,
        //                       label:
        //                        HStack {
        //                            Text("\(selectedAccount.name)")
        //                                .font(.system(.headline))
        //                            Spacer()
        //                            ValueView(showInSatoshi: $showInSatoshi, direction: .horizontal, size: .small, balance: selectedAccount.balance)
        //                        }.padding().background(RoundedRectangle(cornerRadius: 56/3, style: .continuous).frame(height: 56).foregroundColor(.secondary).opacity(0.15))
        //                ) {
        //                    ForEach(Wallet.sample.accounts) { account in
        //                        Text("\(account.name)").tag(account)
        //                    }
        //                }.pickerStyle(MenuPickerStyle()).padding(.horizontal)
        //
        //                Button(action: {}) {
        //                    RoundedRectangle(cornerRadius: 56/3, style: .continuous)
        //                        .frame(height: 56)
        //                        .overlay(Text("Next").foregroundColor(.white).font(.system(.title2)))
        //
        //                }.padding()
        //            }
        //            .navigationBarItems(leading:
        //                                    Button(action: { self.displayValue = "0" }) {
        //                                        Image(systemName: "arrow.clockwise")
        //                                    }.disabled(self.displayValue == "0"))
        //            .navigationTitle(Text("Send"))
        //            .navigationBarTitleDisplayMode(.inline)
        //        }
    }
}
