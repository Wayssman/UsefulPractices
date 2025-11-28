//
//  CustomLayoutExample.swift
//  UsefulPractices
//
//  Created by Alexandr Zhelanov on 12/11/25.
//

import SwiftUI

struct CustomLayoutExample: View {
    // MARK: Properties
    @State var elements: Int = 5
    @State var toggle: Int = 0
    
    // MARK: Layout
    var body: some View {
        GeometryReader { context in
            VStack {
                layoutStack()
                    .padding(50)
                    .frame(
                        maxWidth: context.size.width,
                        maxHeight: context.size.height
                    )
                    .background {
                        PentagramShape(startAngle: .degrees(90))
                            .stroke(Color.accentColor, lineWidth: 3)
                            .padding(50)
                    }
                
                buttonsStack()
                    .padding()
            }
        }
    }
    
    // MARK: Internal
    private func layoutStack() -> some View {
        let layout = switch toggle {
        case 0:
            AnyLayout(HStackLayout())
        case 1:
            AnyLayout(RadialLayout(
                startAngle: .degrees(180)
            ))
        default:
            AnyLayout(PentagramLayout(
                startAngle: .degrees(180)
            ))
        }
        
        return VStack() {
            layout {
                ForEach(0..<elements, id: \.self) { _ in
                    Rectangle()
                        .fill(.red)
                        .frame(width: 30, height: 30)
                        .cornerRadius(5)
                }
            }
            .animation(.default, value: toggle)
            .animation(.default, value: elements)
        }
    }
    
    private func buttonsStack() -> some View {
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
    }
}

#Preview {
    CustomLayoutExample()
}
