//
//  SendView.swift
//  BarimWallet
//
//  Created by Junhyung Cho on 2021/02/13.
//

import SwiftUI

struct SendView: View {
    @State private var showInSatoshi: Bool = false
    @State private var selectedAccount: Account = Wallet.sample.accounts.first!
    @State private var selectedCurrency: Value.Representation = .bch
    @State private var displayValue: String = ""
    @State private var displayAddress: String = ""
    
    @State private var isTyping: Bool = false
    @State private var isSendable: Bool = true
    
    var body: some View {
        numberFieldView
    }
    
    var numberFieldView: some View {
        VStack {
            ZStack {
                Rectangle().foregroundColor(.secondary).opacity(0.01).onTapGesture { hideKeyboard()}
                
                
                
                
                VStack {
                    
                    HStack {
                        Text("From")
                            .font(.system(.headline))
                        Spacer()
                    }.foregroundColor(.secondary).padding(.vertical, 5)
                    
                    Picker(selection: $selectedAccount,
                           label:
                            HStack {
                                Text("\(selectedAccount.name)")
                                    .font(.system(.headline))
                                Spacer()
                                ValueView(showInSatoshi: $showInSatoshi, direction: .horizontal, size: .small, balance: selectedAccount.balance)
                            }.padding().background(RoundedRectangle(cornerRadius: 56/3, style: .continuous).frame(height: 56).foregroundColor(.secondary).opacity(0.15))
                    ) {
                        ForEach(Wallet.sample.accounts) { account in
                            Text("\(account.name)").tag(account)
                        }
                    }.pickerStyle(MenuPickerStyle()).padding(.bottom)
                    
                    
                        HStack {
                            Text("How Much")
                                .font(.system(.headline))
                            Spacer()
                        }.foregroundColor(.secondary).padding(.vertical, 5)
                    
                    NumberField(maximumFontSize: 100, number: $displayValue)
                    
                    Picker(selection: $selectedCurrency, label: Text(selectedCurrency.description)) {
                        Text(Value.Representation.bch.description).tag(Value.Representation.bch)
                        Text(Value.Representation.fiat(.krw).description).tag(Value.Representation.fiat(.krw))
                    }.pickerStyle(SegmentedPickerStyle()).padding(.bottom)
                    
                    
                    
                    VStack {
                        HStack {
                            Text("To")
                                .font(.system(.headline))
                            Spacer()
                        }.foregroundColor(.secondary).padding(.vertical, 5)
                        
                        HStack {
                            AddressField(address: $displayAddress)
                            Spacer()
                            
                            Button(action: {
                                self.displayAddress = UIPasteboard.general.string ?? ""
                            }) {
                                Image(systemName: "doc.on.clipboard")
                            }.font(.system(.title3))//.disabled(UIPasteboard.general.string == nil)
                            
                            Button(action: {}) {
                                Image(systemName: "qrcode.viewfinder")
                            }.font(.system(.title2))
                        }
                        
                        
                        
                    }.padding(.vertical)
                    
                    
                    Spacer()
                    
                    Button(action: { hideKeyboard() }) {
                        RoundedRectangle(cornerRadius: 56/3, style: .continuous)
                            .frame(height: 56)
                            .overlay(Text("Send").foregroundColor(.white).font(.system(.title2)))
                        
                    }.disabled(!isSendable)
                }
                
                
            }
        }.padding()
        .navigationBarItems(leading:
                                Button(action: { self.displayValue = ""; self.displayAddress = "" }) {
                                    Image(systemName: "arrow.clockwise")
                                }.disabled(self.displayValue == "" && self.displayAddress == ""))
        .navigationTitle(Text("Send"))
        .navigationBarTitleDisplayMode(.inline)
    }
    
    var numberPadView: some View {
        GeometryReader { geometry in
            
            VStack {
                Spacer()
                HStack(alignment: .bottom) {
                    Rectangle().frame(width: geometry.size.width/33).opacity(0)
                    VStack(spacing: 0) {
                        
                        
                        Text(displayValue)
                            .lineLimit(1)
                            .font(.system(size: 100, weight: .black, design: .monospaced)).minimumScaleFactor(0.1)
                            .foregroundColor(.primary)
                        
                        
                        Picker(selection: $selectedCurrency, label: Text(selectedCurrency.description)) {
                            Text(Value.Representation.bch.description).tag(Value.Representation.bch)
                            Text(Value.Representation.fiat(.krw).description).tag(Value.Representation.fiat(.krw))
                        }.pickerStyle(SegmentedPickerStyle())
                    }
                    Rectangle().frame(width: geometry.size.width/33).opacity(0)
                }
                
                
                
                NumberPad(value: $displayValue)
                    .frame(height: geometry.size.height / 2)
                    .padding()
                
                
                
                Picker(selection: $selectedAccount,
                       label:
                        HStack {
                            Text("\(selectedAccount.name)")
                                .font(.system(.headline))
                            Spacer()
                            ValueView(showInSatoshi: $showInSatoshi, direction: .horizontal, size: .small, balance: selectedAccount.balance)
                        }.padding().background(RoundedRectangle(cornerRadius: 56/3, style: .continuous).frame(height: 56).foregroundColor(.secondary).opacity(0.15))
                ) {
                    ForEach(Wallet.sample.accounts) { account in
                        Text("\(account.name)").tag(account)
                    }
                }.pickerStyle(MenuPickerStyle()).padding(.horizontal)
                
                Button(action: {}) {
                    RoundedRectangle(cornerRadius: 56/3, style: .continuous)
                        .frame(height: 56)
                        .overlay(Text("Next").foregroundColor(.white).font(.system(.title2)))
                    
                }.padding()
            }
            .navigationBarItems(leading:
                                    Button(action: { self.displayValue = "0" }) {
                                        Image(systemName: "arrow.clockwise")
                                    }.disabled(self.displayValue == "0"))
            .navigationTitle(Text("Send"))
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
