//
//  RadialLayout.swift
//  UsefulPractices
//
//  Created by Alexandr Zhelanov on 12/11/25.
//

import SwiftUI

struct RadialLayout: Layout {
    // MARK: Properties
    let startAngle: Angle
    
    // MARK: Layout
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        proposal.replacingUnspecifiedDimensions()
    }
    
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        let stepAngle: Angle = !subviews.isEmpty ? Angle(
            degrees: 360 / Double(subviews.count)
        ) : .zero
        let radius: CGFloat = min(bounds.width, bounds.height) / 2
        
        for (index, subview) in subviews.enumerated() {
            let rotationAngle = stepAngle * Double(index) + startAngle
            var point = CGPoint(x: 0, y: radius)
                .applying(CGAffineTransform(
                    rotationAngle: rotationAngle.radians
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
}

// MARK: Preview
#Preview {
    RadialLayout(startAngle: .degrees(180)) {
        ForEach(0...10, id: \.self) { _ in
            Circle()
                .frame(width: 50, height: 50)
        }
    }
    .padding(50)
}
