//
//  Transaction.swift
//  BarimWallet
//
//  Created by Junhyung Cho on 2021/02/17.
//

import Foundation

struct Transaction: Identifiable, Hashable {
    let id: UUID = .init()
    let locktime: UInt
    let inputs: Set<Input>
    let outputs: Set<Output>
    
    struct Input: Identifiable, Hashable {
        let id: UUID = .init()
        let previousOutputUUID: UUID
        let unlockingScript: Data
    }
    
    struct Output: Identifiable, Hashable {
        let id: UUID
        let value: UInt
        let lockingScript: Data
    }
}

extension Transaction: Comparable {
    static func < (lhs: Transaction, rhs: Transaction) -> Bool { lhs.locktime < rhs.locktime }
}

extension Transaction {
    enum Kind {
        case input, output
    }
}

// MARK: - Functions
extension Transaction {
    static func createRandomOutputs(count: Int) -> Set<Transaction.Output> {
        var outputs: Set<Transaction.Output> = .init()
        (1...count).forEach { _ in
            let output = Transaction.Output(id: UUID(),
                                            value: UInt.random(in: 1...10_00000000),
                                            lockingScript: Data())
            outputs.insert(output)
        }
        return outputs
    }
    
    static func createInputs(from outputs: Set<Transaction.Output>) -> Set<Transaction.Input> {
        let previousUUIDs = outputs.map{ $0.id }
        var inputs: Set<Transaction.Input> = .init()
        
        for uuid in previousUUIDs {
            inputs.insert(Transaction.Input(previousOutputUUID: uuid,
                                            unlockingScript: Data()))
        }
        
        return inputs
    }
    
    static func createTransaction(from inputs: Set<Transaction.Input>, value: UInt) -> Transaction? {
        var totalValue: UInt = 0
        var usedOutputs: Set<Transaction.Output> = .init()
        
        for input in inputs {
            let previousOutput = BitcoinCash.shared.utxoSet.filter{$0.id == input.id}
            guard previousOutput.count == 1 else { return nil }
            guard let output = previousOutput.first else { return nil }
            totalValue += output.value
            usedOutputs.insert(output)
        }
        
        guard value < totalValue else { return nil }
        let remainingValue = totalValue - value
        let spendingOutput = Transaction.Output(id: UUID(),
                                                value: value,
                                                lockingScript: Data())
        let remainingOutput = Transaction.Output(id: UUID(),
                                                 value: remainingValue,
                                                 lockingScript: Data())
        
        usedOutputs.forEach { BitcoinCash.shared.utxoSet.remove($0) }
        
        return Transaction(locktime: UInt(Date().timeIntervalSince1970),
                           inputs: inputs,
                           outputs: .init([spendingOutput, remainingOutput]))
    }
}
