//
//  RadialLayout.swift
//  UsefulPractices
//
//  Created by Alexandr Zhelanov on 12/11/25.
//

import SwiftUI

struct RadialLayout: Layout {
    let radius: Double
    let startAngle: Angle
    
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        proposal.replacingUnspecifiedDimensions()
    }
    
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        let stepAngle: CGFloat = !subviews.isEmpty ? (360 / CGFloat(subviews.count)) : .zero
        
        for (index, subview) in subviews.enumerated() {
            var point = CGPoint(x: 0, y: radius)
                .applying(CGAffineTransform(
                    rotationAngle: Angle(degrees: stepAngle).radians * Double(index) + startAngle.radians
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
