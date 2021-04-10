//
//  ValueField.swift
//  BarimWallet
//
//  Created by Junhyung Cho on 2021/04/06.
//

import SwiftUI
import Combine

struct ValueField: View {
    let maximumFontSize: CGFloat
    
    @Binding var value: Value
    @Binding var keyboardIsUsing: Bool
    
    var body: some View {
        TextField(value.representation.description, text: $value.displayNumber)
            .font(.system(size: maximumFontSize, weight: .black, design: .monospaced))
            .multilineTextAlignment(.center)
            .minimumScaleFactor(0.33)
            .keyboardType(.decimalPad)
            .onTapGesture { keyboardIsUsing = true }
            .onReceive(Just(value.displayNumber)) { newNumber in
                //print("  - Just got \(newNumber) as \(value.representation.description) / old displayNumber: \(value.displayNumber)")
                
                let filtered: String = filter(newNumber, in: value.representation)
                //print(" -- Filtering \(newNumber) to \(filtered)")
                
                self.value.displayNumber = filtered
                //print("--- Set displayNumber to \(filtered) \(value.representation)")
                
                self.value.satoshi = convert(filtered, from: value.representation)
                //print("--- Set value as \(convert(filtered, from: value.representation))")
            }
    }
    
    func filter(_ text: String, in representation: Value.Representation) -> String {
        var result: String = text
        
        result = result.filter { representation.availableCharacters.contains($0) }
        if result == "0" { result = "" }
        if result.first == "." { result = "0." }
        if result.count > 17 { result = String(result.dropLast()) }
        
        switch representation {
        case .satoshi:
            if let unsigned = UInt(result) {
                if unsigned > 21_000_000_00000000 {
                    result = "2100000000000000"
                }
            } else {
                result = ""
            }
            
        case .bch:
            if let double = Double(result) {
                if double > 21_000_000 {
                    result = "21000000"
                }
                if let small = result.split(separator: ".").last {
                    if small.count > 8 {
                        result = String(result.dropLast())
                    }
                }
            } else {
                if (result.filter { $0 == "." }).count > 1 {
                    result = String(result.dropLast())
                }
            }
            
        case .fiat(let currency):
            if result.count > 1 && result.first == "0" { result = String(result.dropFirst()) }
            
            switch currency {
            case .usd:
                if Double(result) != nil {
                    if let small = result.split(separator: ".").last {
                        if small.count > 2 {
                            result = String(result.dropLast())
                        }
                    }
                } else {
                    if (result.filter { $0 == "." }).count > 1 {
                        result = String(result.dropLast())
                    }
                }
                
            case .krw:
                break
            }
        }
        
        return result
    }
    
    func convert(_ text: String, from representation: Value.Representation) -> Value.Satoshi {
        guard !text.isEmpty else { return 0 }
        
        switch representation {
        case .satoshi:
            return UInt(text)!
            
        case .bch:
            return UInt(Double(text)! * 1_00000000)
            
        case .fiat(let fiat):
            let satoshi = Double(text)! / fiat.rate * 1_00000000
            guard satoshi < Double(UInt.max) else { return Value.maximumSatoshi }
            return UInt(satoshi)
        }
    }
    
    func convert(_ satoshi: Value.Satoshi, in representation: Value.Representation) -> String {
        guard satoshi != 0 else { return "" }
        
        var result: String = ""
        
        switch representation {
        case .satoshi:
            return String(satoshi)
        case .bch:
            return String(format: "%.8f", Double(satoshi) / 1_00000000)
        case .fiat(let fiat):
            switch fiat {
            case .usd:
                result = String(format: "%.2f", Double(satoshi) / 1_00000000 * fiat.rate)
            case .krw:
                result = String(format: "%.0f", Double(satoshi) / 1_00000000 * fiat.rate)
            }
        }
        
        return result
    }
}
