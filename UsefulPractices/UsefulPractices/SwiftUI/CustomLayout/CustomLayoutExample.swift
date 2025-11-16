//
//  CustomLayoutExample.swift
//  UsefulPractices
//
//  Created by Alexandr Zhelanov on 12/11/25.
//

import SwiftUI

struct CustomLayoutExample: View {
    @State var elements: Int = 5
    @State var toggle: Int = 0
    
    var body: some View {
        let layout = switch toggle {
        case 0:
            AnyLayout(HStackLayout())
        case 1:
            AnyLayout(RadialLayout(
                radius: 120,
                startAngle: .degrees(180)
            ))
        default:
            AnyLayout(PentagramLayout(
                radius: 120,
                smallRadius: 40,
                startAngle: .degrees(180)
            ))
        }
        
        VStack {
            VStack(alignment: .center) {
                layout {
                    ForEach(0..<elements, id: \.self) { _ in
                        Rectangle()
                            .fill(.red)
                            .frame(width: 30, height: 30)
                            .cornerRadius(5)
                    }
                }
                .background {
                    PentagramShape(radius: 120)
                        .stroke(Color.accentColor, lineWidth: 3)
                }
                .animation(.default, value: toggle)
                .animation(.default, value: elements)
            }
            .frame(maxHeight: .infinity)
            
            HStack(alignment: .center) {
                Button {
                    toggle = toggle < 2 ? toggle + 1 : 0
                } label: {
                    Text("Change Layout")
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 16)
                .background(Color.accentColor)
                .cornerRadius(12)
                
                Button {
                    elements = Int.random(in: 1...30)
                } label: {
                    Text("Randomize Elements")
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 16)
                .background(Color.accentColor)
                .cornerRadius(12)
            }
            .foregroundStyle(.white)
            .padding()
        }
    }
}

struct PentagramLayout: Layout {
    let radius: Double
    let smallRadius: Double
    let startAngle: Angle
    
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        proposal.replacingUnspecifiedDimensions()
    }
    
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        let subCount = (subviews.count + 5 - 1) / 5
        
        for (index, subview) in subviews.enumerated() {
            let angleIndex = index >= 5 ? index % 5 : index
            let angleSubIndex = index / 5
            let angle = Angle(degrees: Double(angleIndex) * 72).radians
            
            
            var point = CGPoint(x: 0, y: radius)
                .applying(CGAffineTransform(
                    rotationAngle: angle + startAngle.radians
                ))
            
            point.x += bounds.midX
            point.y += bounds.midY
            
            if subviews.count > 5 {
                let stepAngle: CGFloat = (360 / CGFloat(subCount))
                var subpoint = CGPoint(x: 0, y: smallRadius)
                    .applying(CGAffineTransform(
                        rotationAngle: Angle(degrees: stepAngle).radians * Double(angleSubIndex)
                    ))
                
                subpoint.x += point.x
                subpoint.y += point.y
                
                subview.place(at: subpoint, anchor: .center, proposal: .unspecified)
            } else {
                subview.place(at: point, anchor: .center, proposal: .unspecified)
            }
        }
    }
}


struct PentagramShape: Shape {
    let radius: CGFloat
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let center = CGPoint(x: rect.midX, y: rect.midY)
        
        let points = (0..<5).map { i -> CGPoint in
            let angle = Angle.degrees(Double(i) * 72 - 90)
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

#Preview {
    CustomLayoutExample()
}
