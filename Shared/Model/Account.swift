//
//  Account.swift
//  BarimWallet
//
//  Created by Junhyung Cho on 2021/02/16.
//

import Foundation

struct Account: Identifiable {
    let id: UUID = .init()
    let name: String
    let privateKeys: Set<UUID>
    let transactions: Set<Transaction>
    var balance: UInt {
        var totalValue: UInt = 0
        
        for privateKey in privateKeys {
            totalValue += (BitcoinCash.shared.utxoSet.filter{$0.id==privateKey})[0].value
        }
        
        return totalValue
    }
}

extension Account {
    static let samples: [Account] = [.init(name: "Test1",
                                           privateKeys: Account.pickRandomPrivateKeys(),
                                           transactions: .init()),
                                     .init(name: "Test2",
                                           privateKeys: Account.pickRandomPrivateKeys(),
                                           transactions: .init()),
                                     .init(name: "Test3",
                                           privateKeys: Account.pickRandomPrivateKeys(),
                                           transactions: .init()),
                                     .init(name: "Test4",
                                           privateKeys: Account.pickRandomPrivateKeys(),
                                           transactions: .init()),
                                     .init(name: "Test5",
                                           privateKeys: Account.pickRandomPrivateKeys(),
                                           transactions: .init()),
                                     .init(name: "Test6",
                                           privateKeys: Account.pickRandomPrivateKeys(),
                                           transactions: .init()),
                                     .init(name: "Test7",
                                           privateKeys: Account.pickRandomPrivateKeys(),
                                           transactions: .init()),
                                     .init(name: "Test8",
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
