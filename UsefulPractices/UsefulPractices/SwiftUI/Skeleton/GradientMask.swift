//
//  GradientMask.swift
//  UsefulPractices
//
//  Created by Alexandr Zhelanov on 22/1/26.
//

import SwiftUI

/// A view with a gradient, which will be used as an animated mask. The view contains one inclined gradient line.
///
/// Gradient should recive one input parameter – it's phase. Phase it is location of the gradient line on view. It's also very helpful for animating GradientMask.
/// ```
/// GradientMask(phase: 0.5)
/// ```
struct GradientMask: View {
    let phase: CGFloat
    let centerColor = Color.black.opacity(0.5)
    let edgeColor = Color.black.opacity(1)
    
    var body: some View {
        GeometryReader { geo in
            let size = max(geo.size.width, geo.size.height) * 2
            
            LinearGradient(
                gradient: .init(stops: [
                    .init(color: edgeColor, location: phase - 0.1),
                    .init(color: centerColor, location: phase),
                    .init(color: edgeColor, location: phase + 0.1)
                ]),
                startPoint: .leading,
                endPoint: .trailing
            )
            .frame(width: size, height: size)
            .rotationEffect(.degrees(-45))
            .position(x: geo.size.width / 2,
                      y: geo.size.height / 2)
        }
        .ignoresSafeArea()
    }
}

#Preview {
    GradientMask(phase: 0.5)
}
