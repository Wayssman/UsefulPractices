//
//  AnimatedMask.swift
//  UsefulPractices
//
//  Created by Alexandr Zhelanov on 22/1/26.
//

import SwiftUI

struct AnimatedMask: ViewModifier, Animatable {
    var phase: CGFloat
    
    var animatableData: CGFloat {
        get { phase }
        set { phase = newValue }
    }
    
    func body(content: Content) -> some View {
        content
            .mask(
                GradientMask(phase: phase)
                    .scaleEffect(3)
            )
    }
}
