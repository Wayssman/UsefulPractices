//
//  PentagramLayout.swift
//  UsefulPractices
//
//  Created by Alexandr Zhelanov on 29/11/25.
//

import SwiftUI

struct PentagramLayout: Layout {
    // MARK: Properties
    let startAngle: Angle
    
    // MARK: Layout
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        proposal.replacingUnspecifiedDimensions()
    }
    
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        let radius = min(bounds.width, bounds.height) / 2
        
        for (index, subview) in subviews.enumerated() {
            // Index on pentagram 0..<5
            let angleIndex = index >= 5 ? index % 5 : index
            // Pentagram Layout
            let point = getPointOnCircle(
                count: 5,
                index: angleIndex,
                radius: radius,
                startAngle: startAngle
            )
            .offset(by: .init(
                x: bounds.midX,
                y: bounds.midY
            ))
        
            // Size of subviews
            let subviewSize = subview.sizeThatFits(.unspecified)
            let smallRadius = min(subviewSize.width, subviewSize.height)
            
            // Layout elements with the same position on pentagram in circle
            let subCount = Int(ceil(Double(subviews.count) / 5.0))
            // Index on concrete top
            let angleSubIndex = index / 5
            if subviews.count > 5 {
                let subpoint = getPointOnCircle(
                    count: subCount,
                    index: angleSubIndex,
                    radius: smallRadius,
                    startAngle: .zero
                )
                .offset(by: .init(
                    x: point.x,
                    y: point.y
                ))
                
                subview.place(at: subpoint, anchor: .center, proposal: .unspecified)
            } else {
                subview.place(at: point, anchor: .center, proposal: .unspecified)
            }
        }
    }
    
    // MARK: Internal
    func getPointOnCircle(count: Int, index: Int, radius: CGFloat, startAngle: Angle) -> CGPoint {
        guard
            index >= 0,
            index < count
        else { return .zero }
        
        let stepAngle = Angle(degrees: 360 / Double(count))
        let angle = stepAngle * Double(index) + startAngle
        
        return CGPoint(x: 0, y: radius)
            .applying(CGAffineTransform(
                rotationAngle: angle.radians
            ))
    }
}

fileprivate extension CGPoint {
    func offset(by center: CGPoint) -> CGPoint {
        CGPoint(x: x + center.x, y: y + center.y)
    }
}

#Preview {
    PentagramLayout(startAngle: .degrees(180)) {
        ForEach(0...20, id: \.self) { _ in
            Circle()
                .frame(width: 50, height: 50)
        }
    }
    .padding(50)
}
