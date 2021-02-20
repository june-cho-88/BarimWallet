//
//  BitcoinCash.swift
//  BarimWallet
//
//  Created by Junhyung Cho on 2021/02/20.
//

import Foundation

struct BitcoinCash: Blockchain {
    static var shared: BitcoinCash = .init()
    private init() {}
    
    var utxoSet: Set<Transaction.Output> = Transaction.createRandomOutputs(count: 999)
}
