//
//  Value.swift
//  BarimWallet
//
//  Created by Junhyung Cho on 2021/04/01.
//

import Foundation

struct Value: CustomStringConvertible {
    var satoshi: UInt
    var representation: Representation// = .satoshi
    
    var description: String {
        switch self.representation {
        case .satoshi: return satoshi.description
        case .bch: return (satoshi/100_000_000).description
        case .fiat(let currency):
            switch currency {
            case .usd: return "\(String(format: "%.2f", satoshi)) to USD"
            case .krw:  return "\(satoshi) to KRW"
            }
        }
    }
}

extension Value {
    enum Representation: Hashable, CustomStringConvertible {
        case satoshi, bch
        case fiat(Fiat)
        
        var description: String {
            switch self {
            case .satoshi: return "satoshi"
            case .bch: return "BCH"
            case .fiat(let currency): return currency.description
            }
        }
    }
    
    enum Fiat: Hashable, CustomStringConvertible {
        case usd, krw
        
        var description: String {
            switch self {
            case .usd: return "USD"
            case .krw: return "KRW"
            }
        }
    }
}
