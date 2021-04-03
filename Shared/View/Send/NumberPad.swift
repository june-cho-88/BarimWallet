//
//  NumberPad.swift
//  BarimWallet
//
//  Created by Junhyung Cho on 2021/04/03.
//

import SwiftUI

struct NumberPad: View {
    @Binding var value: String
    private var userIsInTheMiddleOfTyping: Bool { value != "0" }
    private var valueHasDot: Bool { value.contains(".") }
    
    private var isAppendable: Bool {
        guard value.last! != "." else { return true }
        
        if valueHasDot {
            let split = value.split(separator: ".")
            return split[1].count < 8
        } else {
            return Int(value)! < 2000000
        }
    }
    
    func check() {
        guard let value = Double(value) else { return }
        
        if value > 2000000 {
            self.value = "2000000"
        }
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                HStack(spacing: 0) {
                    ForEach(1..<4) { hNumber in
                        NumberPadButton(Text(hNumber.description), geometry: geometry, availability: isAppendable) { userIsInTheMiddleOfTyping ? (value += hNumber.description) : (value = hNumber.description); check() }
                    }
                }
                HStack(spacing: 0) {
                    ForEach(4..<7) { hNumber in
                        NumberPadButton(Text(hNumber.description), geometry: geometry, availability: isAppendable) { userIsInTheMiddleOfTyping ? (value += hNumber.description) : (value = hNumber.description); check() }
                    }
                }
                HStack(spacing: 0) {
                    ForEach(7..<10) { hNumber in
                        NumberPadButton(Text(hNumber.description), geometry: geometry, availability: isAppendable) { userIsInTheMiddleOfTyping ? (value += hNumber.description) : (value = hNumber.description); check() }
                    }
                }
                
                
                HStack(spacing: 0) {
                    NumberPadButton(Text(".".description), geometry: geometry, availability: isAppendable) { if !valueHasDot { value += "." }; check() }.disabled(valueHasDot)
                    NumberPadButton(Text("0".description), geometry: geometry, availability: isAppendable) { if userIsInTheMiddleOfTyping { value += "0" }; check() }
                    NumberPadButton(Image(systemName: "delete.left"), geometry: geometry) {
                        if value != "0" {
                            if value.count > 1 {
                                value.removeLast(1)
                            } else {
                                value = "0"
                            }
                        }
                    }.disabled(!userIsInTheMiddleOfTyping)
                }
            }.frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
        }
    }
}

struct NumberPadButton<V: View>: View {
    let element: V
    let geometry: GeometryProxy
    let availability: Bool
    let action: () -> Void
    
    init(_ element: V, geometry: GeometryProxy, availability: Bool = true, action: @escaping () -> Void) {
        self.element = element
        self.action = action
        self.availability = availability
        self.geometry = geometry
    }
    
    var font: Font {
        switch element {
        case is Text: return .system(size: 50, weight: .bold, design: .monospaced)
        case is Image: return .system(size: 35, weight: .bold, design: .monospaced)
        default: fatalError()
        }
    }
    
    var body: some View {
        Button(action: action) {
            element
                .frame(width: geometry.size.width/3, height: geometry.size.height/4, alignment: .center)
                .font(font)
        }.disabled(!availability)
    }
}
