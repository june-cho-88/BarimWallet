//
//  UInt+.swift
//  BarimWallet
//
//  Created by Junhyung Cho on 2021/02/20.
//

import Foundation

extension UInt {
    var satoshi: String { String(self) }
    var bch: String { String(format: "%.8f", Double(self)/1_00000000) }
}
