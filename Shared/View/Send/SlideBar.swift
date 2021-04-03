//
//  SlideBar.swift
//  BarimWallet
//
//  Created by Junhyung Cho on 2021/03/30.
//

import SwiftUI

struct SlideBar: View {
    let slideViewSize: CGFloat = 75
    let maximumSlideWidth: CGFloat = 323 // iPhone 12 Pro Max
    @Binding var available: Bool
    
    @State private var slideOffset: CGFloat = 0
    
    var body: some View {
        if available {
            ZStack(alignment: .leading) {
                Capsule()
                    .frame(height: slideViewSize)
                    .foregroundColor(.bitcoin(.green))
                    .overlay(
                        Capsule()
                            .foregroundColor(.bitcoin(.purple))
                            .opacity(Double(slideOffset*0.25/maximumSlideWidth))
                    )
                    .overlay(
                        Text("Slide to Send")
                            .font(.system(.headline))
                            .foregroundColor(.bitcoin(.white))
                            .opacity(1-Double(slideOffset*3.5/maximumSlideWidth))
                    )
                Image(systemName: "bitcoinsign.circle.fill")
                    .font(.system(size: slideViewSize * 0.85))
                    .foregroundColor(.bitcoin(.white))
                    .rotationEffect(.degrees(Double(-slideOffset/11)))
                    .offset(x: slideOffset)
                    
                    .gesture(
                        DragGesture()
                            .onChanged({ gesture in
                                if gesture.translation.width > 0 && gesture.translation.width < maximumSlideWidth {
                                    self.slideOffset = gesture.translation.width
                                }
                            })
                            .onEnded({ gesture in
                                if gesture.translation.width < maximumSlideWidth * 0.8 {
                                    withAnimation {
                                        self.slideOffset = 0
                                    }
                                } else {
                                    withAnimation {
                                        self.slideOffset = maximumSlideWidth
                                    }
                                }
                                
                            })
                    )
            }
        }
    }
    
    func reset() {
        self.available = false
        self.slideOffset = 0
    }
}
