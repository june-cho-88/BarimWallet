//
//  QRCode.swift
//  BarimWallet
//
//  Created by Junhyung Cho on 2021/04/25.
//

import Foundation
import CoreImage.CIFilterBuiltins
import UIKit.UIImage

struct QRCode {
    let string: String
    
    var uiImage: UIImage {
        let context = CIContext()
        let filter = CIFilter.qrCodeGenerator()
        
        let data = Data(string.utf8)
        filter.setValue(data, forKey: "inputMessage")

        if let outputImage = filter.outputImage {
            if let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
                return UIImage(cgImage: cgImage)
            }
        }

        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
}
