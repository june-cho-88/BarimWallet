//
//  AddressField.swift
//  BarimWallet
//
//  Created by Junhyung Cho on 2021/04/03.
//

import SwiftUI
import Combine

struct AddressField: View {
    @Binding var address: String
    @Binding var keyboardIsUsing: Bool
    @Binding var presentQRCodeScannerView: Bool
    
    let base32Alphabets: String = "qpzry9x8gf2tvdw0s3jn54khce6mua7l"
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 0) {
                Text("bitcoincash:").foregroundColor(.secondary)
                    .font(Font.system(.caption2, design: .monospaced).weight(.regular))
                TextField("Address", text: $address)
                    .font(Font.system(.callout, design: .monospaced).weight(.bold))
                    .minimumScaleFactor(0.666)
                    .keyboardType(.default)
                    .onReceive(Just(address)) { newValue in
                        var resultValue: String = newValue.starts(with: "bitcoincash:") ? String(newValue.dropFirst(12)) : newValue
                        resultValue = resultValue.filter { base32Alphabets.contains($0) }
                        
                        if resultValue.count > 42 {
                            self.address = String(resultValue.dropLast(resultValue.count - 42))
                        } else {
                            self.address = resultValue
                        }
                    }
                    .onTapGesture { keyboardIsUsing = true }
            }
            
            Spacer()
            
            Button(action: {
                self.address = UIPasteboard.general.string ?? ""
            }) {
                Image(systemName: "doc.on.clipboard")
            }
            .font(.system(.headline))
            .buttonStyle(BorderlessButtonStyle())
            
            Button(action: { presentQRCodeScannerView = true }) {
                Image(systemName: "qrcode.viewfinder")
            }
            .font(.system(.title2))
            .buttonStyle(BorderlessButtonStyle())
            .sheet(isPresented: $presentQRCodeScannerView) {
                QRCodeScannerView(presentQRCodeScannerView: $presentQRCodeScannerView,
                                  address: $address)
            }
            
        }
    }
}
