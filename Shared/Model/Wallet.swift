//
//  Wallet.swift
//  BarimWallet
//
//  Created by Junhyung Cho on 2021/02/16.
//

import Foundation

struct Wallet: Identifiable {
    let id: UUID = .init()
    let accounts: [Account]
}

extension Wallet: Hashable {}

extension Wallet {
    static let sample: Wallet = .init(accounts: Account.samples)
}


// MARK: - Functions
extension Wallet {}
