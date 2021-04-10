//
//  CounterCurrencyView.swift
//  BarimWallet
//
//  Created by Junhyung Cho on 2021/04/08.
//

import SwiftUI

struct CounterCurrencyView: View {
    @Binding var value: Value
    
    var body: some View {
        let converted: String = value.convertValue(to: value.counterRepresentation)
        
        HStack {
            Spacer()
            Image(systemName: "equal.circle")
                .foregroundColor(.secondary)
                .font(.system(.footnote, design: .monospaced))
            HStack(alignment: .firstTextBaseline, spacing: 3) {
                Text(converted.isEmpty ? "0" : converted)
                    .foregroundColor(.primary)
                    .font(.system(.headline, design: .monospaced))
                    .fontWeight(.semibold)
                Text(value.counterRepresentation.description)
                    .foregroundColor(.secondary)
                    .font(.system(.subheadline, design: .monospaced))
                    .fontWeight(.medium)
            }
            Spacer()
        }
    }
}
