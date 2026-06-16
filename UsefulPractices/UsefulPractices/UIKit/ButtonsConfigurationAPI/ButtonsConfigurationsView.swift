//
//  ButtonsConfigurationsView.swift
//  UsefulPractices
//
//  Created by Alexandr Zhelanov on 17.06.2026.
//

import UIKit
import SwiftUI

final class ButtonsConfigurationsView: UIView {
    private let buttonsStack = UIStackView()
    private let tintedButton = UIButton()
    
    // MARK: Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension ButtonsConfigurationsView {
    func layout() {
        NSLayoutConstraint.activate([
            /*buttonsStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            buttonsStack.trailingAnchor.constraint(equalTo: trailingAnchor),*/
            buttonsStack.centerXAnchor.constraint(equalTo: centerXAnchor),
            buttonsStack.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    func setup() {
        // Buttons Stack
        buttonsStack.axis = .vertical
        buttonsStack.spacing = 12
        buttonsStack.translatesAutoresizingMaskIntoConstraints = false
        addSubview(buttonsStack)
        
        // Tinted Button
        var tintedButtonConfiguration = UIButton.Configuration.tinted()
        tintedButtonConfiguration.title = "Add to Cart"
        tintedButtonConfiguration.image = UIImage(systemName: "cart.badge.plus")
        tintedButtonConfiguration.imagePlacement = .trailing
        tintedButtonConfiguration.buttonSize = .large
        tintedButtonConfiguration.cornerStyle = .capsule
        
        tintedButton.configuration = tintedButtonConfiguration
        tintedButton.translatesAutoresizingMaskIntoConstraints = false
        buttonsStack.addArrangedSubview(tintedButton)
    }
}

// MARK: Wrapper
struct ButtonsConfigurationsViewWrapper: UIViewRepresentable {
    func makeUIView(context: Context) -> some UIView {
        ButtonsConfigurationsView()
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
    
    }
}

// MARK: Preview
#Preview {
    ButtonsConfigurationsViewWrapper()
        .padding()
}
