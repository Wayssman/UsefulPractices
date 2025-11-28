//
//  PentagramShape.swift
//  UsefulPractices
//
//  Created by Alexandr Zhelanov on 29/11/25.
//

import SwiftUI

struct PentagramShape: Shape {
    // MARK: Properties
    let startAngle: Angle
    
    // MARK: Draw
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let radius: CGFloat = min(rect.height, rect.width) / 2
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let step: Double = 360 / 5
        
        let points = (0..<5).map { i -> CGPoint in
            let angle = Angle.degrees(Double(i) * step - startAngle.degrees)
            let x = center.x + cos(angle.radians) * radius
            let y = center.y + sin(angle.radians) * radius
            return CGPoint(x: x, y: y)
        }
        
        path.move(to: points[0])
        path.addLine(to: points[2])
        path.addLine(to: points[4])
        path.addLine(to: points[1])
        path.addLine(to: points[3])
        path.closeSubpath()
        
        return path
    }
}

// MARK: Preview
#Preview {
    PentagramShape(startAngle: .degrees(90))
}
