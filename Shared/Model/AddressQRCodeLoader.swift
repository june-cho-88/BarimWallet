//
//  AddressQRCodeLoader.swift
//  BarimWallet
//
//  Created by Junhyung Cho on 2021/04/30.
//

import Foundation
import Combine
import SwiftUI

class AddressQRCodeLoader: ObservableObject {
    @Published var image: Image?
    private let address: String
    
    private var cancellable: AnyCancellable?
    
    init(address: String) {
        self.address = address
    }
    
    deinit {
        cancel()
    }
    
    func load() {
        DispatchQueue.main.async {
            self.image = Image(uiImage: QRCode(string: self.address).uiImage)
        }
    }
    
    func cancel() {
        cancellable?.cancel()
    }
}
