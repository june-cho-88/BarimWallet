//
//  ValueView.swift
//  BarimWallet
//
//  Created by Junhyung Cho on 2021/03/29.
//

import SwiftUI

struct ValueView: View {
    @Binding var showInSatoshi: Bool
    
    let direction: Direction
    let size: Size
    
    let balance: UInt
    
    var valueFont: Font {
        switch (direction, size) {
        case (.vertical, .small): return .system(.subheadline, design: .monospaced)
        case (.vertical, .large): return .system(.largeTitle, design: .monospaced)
        case (.horizontal, .small): return .system(.callout, design: .monospaced)
        case (.horizontal, .large): return .system(.largeTitle, design: .monospaced)
        }
    }
    
    var currencyFont: Font {
        switch (direction, size) {
        case (.vertical, .small): return .system(.caption2)
        case (.vertical, .large): return .system(.title2)
        case (.horizontal, .small): return .system(.caption)
        case (.horizontal, .large): return .system(.title)
        }
    }
    
    var body: some View {
        switch direction {
        case .vertical: verticalView
        case .horizontal: horizontalView
        }
    }
    
    var verticalView: some View {
        VStack(alignment: .trailing) {
            Text(showInSatoshi ? balance.satoshi : balance.bch)
                .font(valueFont)
                .fontWeight(.none)
                .foregroundColor(.primary)
            Text(showInSatoshi ? "satoshi" : "BCH")
                .font(currencyFont)
                .foregroundColor(.secondary)
        }
    }
    
    var horizontalView: some View {
        HStack(alignment: .bottom, spacing: 3) {
            Text(showInSatoshi ? balance.satoshi : balance.bch)
                .font(valueFont)
                .fontWeight(.semibold)
                .foregroundColor(.primary)
            Text(showInSatoshi ? "satoshi" : "BCH")
                .font(currencyFont)
                .foregroundColor(.secondary)
        }
    }
}

extension ValueView {
    enum Direction {
        case vertical, horizontal
    }
    
    enum Size {
        case large, small
    }
}
