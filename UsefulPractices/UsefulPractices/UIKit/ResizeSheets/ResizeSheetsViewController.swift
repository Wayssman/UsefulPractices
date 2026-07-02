//
//  ResizeSheetsViewController.swift
//  UsefulPractices
//
//  Created by Alexandr Zhelanov on 19.06.2026.
//

import UIKit
import SwiftUI

final class ResizeSheetsViewController: UIViewController {
    let presentButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

private extension ResizeSheetsViewController {
    func setup() {
        var buttonConfiguraiton = UIButton.Configuration.tinted()
        buttonConfiguraiton.baseBackgroundColor = .systemBlue
        buttonConfiguraiton.title = "Show"
        
        presentButton.configuration = buttonConfiguraiton
        presentButton.addAction(.init { [weak self] _ in
            self?.presentSheet()
        }, for: .touchUpInside)
        
        presentButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(presentButton)
        NSLayoutConstraint.activate([
            presentButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            presentButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    func presentSheet() {
        let newViewController = ResizeSheetsPresentableViewController()
        
        newViewController.didSelectColor = { [weak self] color in
            self?.view.backgroundColor = color
            
            if let sheet = newViewController.sheetPresentationController {
                sheet.animateChanges {
                    sheet.selectedDetentIdentifier = .medium
                }
            }
        }
        
        if let sheet = newViewController.sheetPresentationController {
            
            // DETENTS
            // Only medium detent
            //sheet.detents = [.medium()]
            // Supports two detents and can be resized between them
            sheet.detents = [.medium(), .large()]
            
            // SCROLL
            // Disable sheet expanding on scroll
            //sheet.prefersScrollingExpandsWhenScrolledToEdge = true
            
            // DIM
            sheet.largestUndimmedDetentIdentifier = nil//.medium
            
            // UI
            sheet.prefersGrabberVisible = true
            sheet.preferredCornerRadius = 24
        }
        
        present(newViewController, animated: true)
    }
}

#Preview {
    ResizeSheetsViewController()
}
