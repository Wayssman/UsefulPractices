//
//  CustomLayoutExample.swift
//  UsefulPractices
//
//  Created by Alexandr Zhelanov on 12/11/25.
//

import SwiftUI

struct CustomLayoutExample: View {
    var body: some View {
        RadialLayout(radius: 100, startAngle: 0, stepAngle: 45) {
            ForEach(0..<8, id: \.self) { _ in
                Circle()
                    .fill(.red)
                    .frame(width: 50, height: 50)
            }
        }
    }
}

struct RadialLayout: Layout {
    let radius: Double
    let startAngle: CGFloat
    let stepAngle: CGFloat
    
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        proposal.replacingUnspecifiedDimensions()
    }
    
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        for (index, subview) in subviews.enumerated() {
            var point = CGPoint(x: 0, y: radius)
                .applying(CGAffineTransform(
                    rotationAngle: degreesToRadians(stepAngle) * Double(index) + degreesToRadians(startAngle)
                ))
            
            point.x += bounds.midX
            point.y += bounds.midY
            
            subview.place(
                at: point,
                anchor: .center,
                proposal: .unspecified
            )
        }
    }
    
    private func degreesToRadians(_ degrees: CGFloat) -> CGFloat {
        degrees * CGFloat.pi / 180
    }
}

#Preview {
    CustomLayoutExample()
}
