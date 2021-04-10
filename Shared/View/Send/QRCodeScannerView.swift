//
//  QRCodeScannerView.swift
//  BarimWallet
//
//  Created by Junhyung Cho on 2021/04/10.
//

import SwiftUI

struct QRCodeScannerView: View {
    @Binding var presentQRCodeScannerView: Bool
    @Binding var address: String
    
    var body: some View {
        List {
            Section(header:
                        HStack {
                            Spacer()
                            Button(action: { presentQRCodeScannerView = false }) {
                                Image(systemName: "chevron.compact.down")
                                    .font(.system(.title))
                                    .padding()
                            }
                            .buttonStyle(BorderlessButtonStyle())
                            Spacer()
                        },
                    footer:
                        HStack {
                            Spacer()
                            Image(systemName: "qrcode.viewfinder")
                                .font(.system(size: 300))
                            Spacer()
                        }
            ) {}
        }
        .listStyle(GroupedListStyle())
    }
}
