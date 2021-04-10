//
//  Account.swift
//  BarimWallet
//
//  Created by Junhyung Cho on 2021/02/16.
//

import Foundation

struct Account: Identifiable, Hashable {
    let id: UUID = .init()
    let name: String
    let lock: Bool
    let privateKeys: Set<UUID>
    let transactions: Set<Transaction>
    
    var balance: UInt {
        let totalValue: UInt = UInt.random(in: 1...9999999999)
        // TODO: Put this calculation to background
//        DispatchQueue.main.async {
//            for privateKey in privateKeys {
//                totalValue += (BitcoinCash.shared.utxoSet.filter{$0.id==privateKey})[0].value
//            }
//        }
        return totalValue
    }
    
    func getBalance(in currency: Value.Representation) -> String {
        return Value(balance, representation: currency).description
    }
}

extension Account {
    static let samples: [Account] = [.init(name: "Personal",
                                           lock: false,
                                           privateKeys: Account.pickRandomPrivateKeys(),
                                           transactions: .init()),
                                     .init(name: "Test Account 2",
                                           lock: false,
                                           privateKeys: Account.pickRandomPrivateKeys(),
                                           transactions: .init()),
                                     .init(name: "Life Saving",
                                           lock: true,
                                           privateKeys: Account.pickRandomPrivateKeys(),
                                           transactions: .init()),
                                     .init(name: "Saving for New Car",
                                           lock: true,
                                           privateKeys: Account.pickRandomPrivateKeys(),
                                           transactions: .init()),
                                     .init(name: "Test Account 5",
                                           lock: false,
                                           privateKeys: Account.pickRandomPrivateKeys(),
                                           transactions: .init()),
                                     .init(name: "Test Account 6",
                                           lock: false,
                                           privateKeys: Account.pickRandomPrivateKeys(),
                                           transactions: .init()),
                                     .init(name: "Test Account 7",
                                           lock: false,
                                           privateKeys: Account.pickRandomPrivateKeys(),
                                           transactions: .init()),
                                     .init(name: "Locked Account",
                                           lock: true,
                                           privateKeys: Account.pickRandomPrivateKeys(),
                                           transactions: .init()),]
}

// MARK: - Functions
extension Account {
    static func pickRandomPrivateKeys() -> Set<UUID> {
        var privateKeys: Set<UUID> = .init()
        
        guard (BitcoinCash.shared.utxoSet.count) > 1 else { return privateKeys }
        
        let count = Int.random(in: 1...(BitcoinCash.shared.utxoSet.count))
        (1...count).forEach { _ in
            if let output = BitcoinCash.shared.utxoSet.randomElement() {
                privateKeys.insert(output.id)
            }
        }
        
        return privateKeys
    }
}
