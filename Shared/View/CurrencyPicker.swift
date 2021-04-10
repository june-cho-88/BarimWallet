//
//  CurrencyPicker.swift
//  BarimWallet
//
//  Created by Junhyung Cho on 2021/04/03.
//

import SwiftUI

struct CurrencyPicker: View {
    @Binding var currency: Value.Representation
    
    var body: some View {
        Picker(selection: $currency,
               label: Text(currency.description)) {
            Text(Value.Representation.bch.description).tag(Value.Representation.bch)
            Text(Value.Representation.fiat(.krw).description).tag(Value.Representation.fiat(.krw))
        }
        .pickerStyle(SegmentedPickerStyle())
    }
}
