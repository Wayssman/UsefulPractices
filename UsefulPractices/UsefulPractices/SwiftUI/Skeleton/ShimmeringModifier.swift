//
//  ShimmeringModifier.swift
//  UsefulPractices
//
//  Created by Alexandr Zhelanov on 22/1/26.
//

import SwiftUI

public struct ShimmeringModifier: ViewModifier {
    @State private var phase: CGFloat = 0
    
    public func body(content: Content) -> some View {
        content
            .modifier(AnimatedMask(phase: phase))
            .onAppear {
                withAnimation(
                    .linear(duration: 2)
                    .repeatForever(autoreverses: false)
                ) {
                    phase = 1
                }
            }
    }
}
