//
//  GradientMask.swift
//  UsefulPractices
//
//  Created by Alexandr Zhelanov on 22/1/26.
//

import SwiftUI

struct GradientMask: View {
    let phase: CGFloat
    let centerColor = Color.black.opacity(0.5)
    let edgeColor = Color.black.opacity(1)
    
    var body: some View {
        VStack {
            LinearGradient(
                gradient: .init(stops: [
                    .init(color: edgeColor, location: phase - 0.1),
                    .init(color: centerColor, location: phase),
                    .init(color: edgeColor, location: phase + 0.1)
                ]),
                startPoint: .init(x: 0, y: 0.5),
                endPoint: .init(x: 1, y: 0.5)
            )
            .scaleEffect(3)
            .rotationEffect(.degrees(-45))
        }
    }
}

#Preview {
    GradientMask(phase: 0.5)
}
