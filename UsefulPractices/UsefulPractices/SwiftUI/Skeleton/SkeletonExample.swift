//
//  SkeletonExample.swift
//  UsefulPractices
//
//  Created by Alexandr Zhelanov on 22/1/26.
//

import SwiftUI

struct SkeletonExample: View {
    let isLoading: Bool
    let oneLine = "Hello, World!"
    let multipleLines =
        """
        Hellow, World!
        Hellow, World! Hellow, World, Hellow, World!
        """
    
    var body: some View {
        HStack {
            Image(.headBase)
                .resizable()
                .frame(width: 140, height: 140)
                .skeleton(
                    Circle(),
                    isLoading: isLoading
                )
            
            VStack(alignment: .leading, spacing: 4) {
                Text(oneLine)
                    .bold()
                    .lineLimit(1, reservesSpace: false)
                    .skeleton(
                        Capsule(),
                        .green.opacity(0.8),
                        isLoading: isLoading
                    )
                
                Text(multipleLines)
                    .skeleton(isLoading: isLoading)
            }
        }
    }
}

#Preview {
    SkeletonExample(isLoading: false)
    SkeletonExample(isLoading: true)
}
