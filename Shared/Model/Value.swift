//
//  Value.swift
//  BarimWallet
//
//  Created by Junhyung Cho on 2021/04/01.
//

import Foundation

struct Value {
    typealias Satoshi = UInt
    static let maximumSatoshi: Satoshi = 21_000_000_00000000
    
    var satoshi: Satoshi
    var representation: Representation
    var displayNumber: String
    
    init(_ satoshi: Satoshi, representation: Representation = .satoshi) {
        self.satoshi = satoshi
        self.representation = representation
        self.displayNumber = (satoshi == 0) ? "" : String(satoshi)
    }
}

extension Value {
    var counterRepresentation: Value.Representation {
        switch self.representation {
        case .satoshi, .bch:
            return .fiat(.krw)
        case .fiat(_):
            return .bch
        }
    }
}

extension Value {
    func convertValue(to currency: Representation) -> String {
        guard self.satoshi != 0 else { return "" }
        
        var result: String = ""
        
        switch currency {
        case .satoshi:
            result = String(satoshi)
        case .bch:
            let split = String(format: "%.8f", Double(satoshi) / 1_00000000).split(separator: ".")
            let big = String(split.first!)
            result = big
            if let small = split.last {
                result = big + ".\(small)"
                while result.last == "0" { result = String(result.dropLast()) }
                if result.last == "." { result = String(result.dropLast()) }
            }
            
        case .fiat(let fiat):
            switch fiat {
            case .usd:
                result = String(format: "%.2f", Double(satoshi) / 1_00000000 * Fiat.usd.rate)
            case .krw:
                result = String(format: "%.0f", Double(satoshi) / 1_00000000 * Fiat.krw.rate)
            }
        }
        
        return result
    }
}

extension Value: CustomStringConvertible {
    var description: String {
        return convertValue(to: representation)
    }
}

extension Value {
    enum Representation: Hashable, CustomStringConvertible {
        case satoshi, bch
        case fiat(Fiat)
        
        mutating func toggle() {
            switch self {
            case .bch:
                self = .satoshi
            case .satoshi:
                self = .bch
            case .fiat(_):
                self = .bch
            }
        }
        
        var buttonImageName: String {
            switch self {
            case .satoshi:
                return "s.circle"
            case .bch:
                return "bitcoinsign.circle.fill"
            case .fiat(let currency):
                switch currency {
                case .usd:
                    return "dollarsign.square"
                case .krw:
                    return "wonsign.square"
                }
            }
        }
        
        var availableCharacters: String {
            switch self {
            case .satoshi, .fiat(.krw):
                return "0123456789"
            case .bch, .fiat(.usd):
                return "0123456789."
            }
        }
        
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
        
        var rate: Double {
            switch self {
            case .usd: return 0.0
            case .krw: return 1_700_000.0
            }
        }
        
        var description: String {
            switch self {
            case .usd: return "USD"
            case .krw: return "KRW"
            }
        }
    }
}
