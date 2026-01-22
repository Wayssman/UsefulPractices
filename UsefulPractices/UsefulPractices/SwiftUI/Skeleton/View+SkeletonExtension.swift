//
//  View+SkeletonExtension.swift
//  UsefulPractices
//
//  Created by Alexandr Zhelanov on 22/1/26.
//

import SwiftUI

public extension View {
    func skeleton<S>(
        _ shape: S? = nil as Rectangle?,
        _ color: Color? = nil,
        isLoading: Bool
    ) -> some View where S: Shape {
        guard isLoading else { return AnyView(self) }
        let skeletonColor = color ?? Color.gray.opacity(0.5)
        
        let skeletonShape: AnyShape = if let shape {
            AnyShape(shape)
        } else {
            AnyShape(
                RoundedRectangle(
                    cornerSize: .init(
                        width: 8,
                        height: 8
                    )
                )
            )
        }
        
        return AnyView(
            opacity(0)
                .overlay(skeletonShape.fill(skeletonColor))
                .shimmering()
        )
    }
    
    func shimmering() -> some View {
        modifier(ShimmeringModifier())
    }
}
