//
//  AlphaSelectLayerHackViewWrapper.swift
//  UsefulPractices
//
//  Created by Alexandr Zhelanov on 29/11/25.
//

import SwiftUI

struct AlphaSelectLayerHackViewWrapper: UIViewRepresentable {
    func makeUIView(context: Context) -> AlphaSelectLayerHackView {
        AlphaSelectLayerHackView()
    }
    
    func updateUIView(_ uiView: AlphaSelectLayerHackView, context: Context) {
        
    }
}

#Preview {
    AlphaSelectLayerHackViewWrapper()
        .aspectRatio(contentMode: .fit)
}
