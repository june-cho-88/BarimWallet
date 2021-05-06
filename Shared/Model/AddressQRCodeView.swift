//
//  AddressQRCodeView.swift
//  BarimWallet
//
//  Created by Junhyung Cho on 2021/04/30.
//

import SwiftUI

struct AddressQRCodeView<Placeholder: View>: View {
    @StateObject private var loader: AddressQRCodeLoader
    private let placeholder: Placeholder
    
    init(address: String, placeholder: Placeholder) {
        var cashAddress: String
        
        if address.starts(with: "bitcoincash:") {
            cashAddress = address
        } else {
            cashAddress = "bitcoincash:" + address
        }
        
        _loader = StateObject(wrappedValue: AddressQRCodeLoader(address: cashAddress))
        self.placeholder = placeholder
    }
    
    var body: some View {
        HStack {
            Spacer()
            if loader.image == nil {
                placeholder
            } else {
                loader.image!
                    .interpolation(.none)
                    .resizable()
                    .scaledToFit()
            }
            Spacer()
        }
        .padding()
        .onAppear(perform: { loader.load() })
    }
}
