//
//  ButtonsConfigurationsView.swift
//  UsefulPractices
//
//  Created by Alexandr Zhelanov on 17.06.2026.
//

import UIKit
import SwiftUI

final class ButtonsConfigurationsView: UIView {
    // MARK: Proeprties
    private var itemQuantityDescription: String? {
        didSet {
            buttonsStack.arrangedSubviews.compactMap { $0 as? UIButton }.forEach {
                $0.setNeedsUpdateConfiguration()
            }
        }
    }
    
    // MARK: Subviews
    private let buttonsStack = UIStackView()
    
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
        
        clearStack()
        addNewButton(with: .plain())
        addNewButton(with: .gray())
        addNewButton(with: .tinted())
        addNewButton(with: .filled())
        addNewPopupButton()
        addCoolMenuButton()
    }
    
    func clearStack() {
        buttonsStack.arrangedSubviews.forEach {
            $0.removeFromSuperview()
        }
    }
    
    func addNewButton(with configuration: UIButton.Configuration) {
        // Configuration
        var configuration = configuration
        configuration.title = "Add to Cart"
        configuration.subtitle = "+4 of smth"
        configuration.image = UIImage(systemName: "cart.badge.plus")
        configuration.imagePlacement = .trailing
        configuration.buttonSize = .large
        configuration.cornerStyle = .capsule
        
        // Button
        let button = UIButton(
            configuration: configuration,
            primaryAction: .init { [unowned self] action in
                self.itemQuantityDescription = ["+1 tomatto", "+2 banana", "+3 oranges"].randomElement()
            }
        )
        button.configurationUpdateHandler = { [unowned self] button in
            var config = button.configuration
            config?.image = button.isHighlighted
                ? UIImage(systemName: "cart.fill.badge.plus")
                : UIImage(systemName: "cart.badge.plus")
            config?.subtitle = self.itemQuantityDescription
            button.configuration = config
        }
        // Turn into toggle button
        button.changesSelectionAsPrimaryAction = true
        // Set selected state
        //button.isSelected = true
        
        // Layout
        button.translatesAutoresizingMaskIntoConstraints = false
        buttonsStack.addArrangedSubview(button)
    }
    
    func addNewPopupButton() {
        let colorClosure = { (action: UIAction) in
            print(action.title)
        }
        
        let button = UIButton(primaryAction: nil)
        button.menu = UIMenu(children: [
            UIAction(title: "Bondi Blue", handler: colorClosure),
            UIAction(title: "Flower Powder", state: .on, handler: colorClosure)
        ])
        button.showsMenuAsPrimaryAction = true
        button.changesSelectionAsPrimaryAction = true
        button.preferredBehavioralStyle = .automatic
        
        // Layout
        button.translatesAutoresizingMaskIntoConstraints = false
        buttonsStack.addArrangedSubview(button)
    }
    
    func addCoolMenuButton() {
        let sortClosure = { (action: UIAction) in
            print(action.title)
        }
        let refreshClosure = { (action: UIAction) in
            print(action.title)
        }
        let accountClosure = { (action: UIAction) in
            print(action.title)
        }
        
        let sortMenu = UIMenu(title: "Sort By", options: .singleSelection, children: [
            UIAction(title: "Title", handler: sortClosure),
            UIAction(title: "Date", handler: sortClosure),
            UIAction(title: "Size", handler: sortClosure)
        ])
        
        let topMenu = UIMenu(children: [
            UIAction(title: "Refresh", handler: refreshClosure),
            UIAction(title: "Account", handler: accountClosure),
            sortMenu
        ])
        
        
        let button = UIButton(
            configuration: .tinted(),
            primaryAction: nil
        )
        button.configuration?.title = "Menu"
        button.menu = topMenu
        button.showsMenuAsPrimaryAction = true
        
        // Layout
        button.translatesAutoresizingMaskIntoConstraints = false
        buttonsStack.addArrangedSubview(button)
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
