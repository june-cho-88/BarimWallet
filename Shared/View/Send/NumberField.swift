//
//  NumberField.swift
//  BarimWallet
//
//  Created by Junhyung Cho on 2021/04/02.
//

import SwiftUI
import Combine

struct NumberField: View {
    let maximumFontSize: CGFloat
    
    @Binding var number: String
    
    var body: some View {
        TextField("0", text: $number)
            .keyboardType(.decimalPad)
            .multilineTextAlignment(.center)
            .font(.system(size: maximumFontSize, weight: .black, design: .monospaced)).minimumScaleFactor(0.01)
            .onReceive(Just(number)) { newValue in
                if let doubleValue = Double(newValue) {
                    if newValue.first == "0" { self.number = String(newValue.dropFirst()) }
                    if doubleValue > 2_000_000 { self.number = "2000000" }
                    if let smallValue = newValue.split(separator: ".").last {
                        if smallValue.count > 8 { self.number = String(newValue.dropLast()) }
                    }
                } else {
                    self.number = newValue.filter { "0123456789.".contains($0) }
                    if (newValue.filter { $0 == "." }.count) > 1 { self.number = String(newValue.dropLast()) }
                }
            }
    }
}
