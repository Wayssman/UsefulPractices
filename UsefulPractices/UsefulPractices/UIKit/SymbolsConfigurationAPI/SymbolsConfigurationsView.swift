//
//  SymbolsConfigurationsView.swift
//  UsefulPractices
//
//  Created by Alexandr Zhelanov on 17.06.2026.
//

import UIKit
import SwiftUI

final class SymbolsConfigurationsView: UIView {
    // MARK: Subview
    private let imagesStack = UIStackView()
    
    // MARK: Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension SymbolsConfigurationsView {
    func setup() {
        // Images Stack
        imagesStack.axis = .vertical
        imagesStack.spacing = 24
        imagesStack.translatesAutoresizingMaskIntoConstraints = false
        addSubview(imagesStack)
        
        NSLayoutConstraint.activate([
            imagesStack.centerXAnchor.constraint(equalTo: centerXAnchor),
            imagesStack.centerYAnchor.constraint(equalTo: centerYAnchor),
            imagesStack.widthAnchor.constraint(equalToConstant: 100)
        ])
        
        clearStack()
        addNewImage(with: .init(hierarchicalColor: .systemOrange))
        addNewImage(with: .init(paletteColors: [
            .red, .green, .blue
        ]))
        addNewImage(with: .preferringMonochrome())
        addNewImage(with: .preferringMulticolor())
    }
    
    func clearStack() {
        imagesStack.arrangedSubviews.forEach {
            $0.removeFromSuperview()
        }
    }
    
    func addNewImage(with configuration: UIImage.SymbolConfiguration) {
        // Image View
        let imageView = UIImageView()
        imageView.image = UIImage(
            systemName: "cloud.sun.rain.fill",
            withConfiguration: configuration
        )
        imageView.backgroundColor = .black.withAlphaComponent(0.25)
        imageView.layer.cornerRadius = 24
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imagesStack.addArrangedSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 1)
        ])
    }
}

// MARK: Wrapper
struct SymbolsConfigurationsViewWrapper: UIViewRepresentable {
    func makeUIView(context: Context) -> some UIView {
        SymbolsConfigurationsView()
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}

// MARK: Preview
#Preview {
    SymbolsConfigurationsViewWrapper()
        .padding()
}
