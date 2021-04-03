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
    
    let base32Alphabets: String = "qpzry9x8gf2tvdw0s3jn54khce6mua7l"
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("bitcoincash:").foregroundColor(.secondary)
                .font(Font.system(.caption2, design: .monospaced).weight(.regular))
            TextField("Amount", text: $address)
                .font(Font.system(.caption, design: .monospaced).weight(.semibold))
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
        }
    }
}
