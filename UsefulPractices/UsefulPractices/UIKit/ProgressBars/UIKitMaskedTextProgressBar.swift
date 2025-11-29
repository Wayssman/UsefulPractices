//
//  UIKitMaskedTextProgressBar.swift
//  UsefulPractices
//
//  Created by Alexandr Zhelanov on 29/11/25.
//

import UIKit
import SwiftUI

final class UIKitMaskedTextProgressBar: UIView {
    // MARK: Properties
    private(set) var progressBarValue: Float = 0
    private var timer: Timer?
    
    // MARK: Subviews
    private let progressFillLayer = CALayer()
    private let progressMaskLayer = CALayer()
    private let whiteIndicatorLabel = UILabel()
    private let blackIndicatorLabel = UILabel()
    
    // MARK: Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        layout()
        
        timer = Timer.scheduledTimer(withTimeInterval: 2, repeats: true) { [weak self] _ in
            guard let self else { return }
            
            var newValue = Float.random(in: 0...1)
            newValue = newValue > 1 ? 0 : newValue
            updateProgress(newValue)
        }
        timer?.fire()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        timer?.invalidate()
    }
    
    // MARK: Layout
    override func layoutSubviews() {
        super.layoutSubviews()
        updateProgressBar()
    }
    
    // MARK: Interface
    func updateProgress(_ value: Float) {
        // Progress Text
        let progressText = String(format: "%.0f out of 100", value * 100)
        whiteIndicatorLabel.text = progressText
        blackIndicatorLabel.text = progressText
        
        // Progress Bar
        let clamped = max(0, min(1, value))
        progressBarValue = clamped
        
        setNeedsLayout()
        layoutIfNeeded()
        
        // UIKit will adds default animations to position and bounds. Uncomment to see:
        //print(progressFillLayer.animationKeys())
    }
    
    // MARK: Internal
    private func updateProgressBar() {
        let width = bounds.width * CGFloat(progressBarValue)
        let rect = CGRect(x: 0, y: 0, width: width, height: bounds.height)
        
        progressFillLayer.frame = rect
        progressMaskLayer.frame = rect
    }
}

// MARK: - Setup
private extension UIKitMaskedTextProgressBar {
    func layout() {
        NSLayoutConstraint.activate([
            whiteIndicatorLabel.topAnchor.constraint(equalTo: topAnchor),
            whiteIndicatorLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            whiteIndicatorLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            whiteIndicatorLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            blackIndicatorLabel.topAnchor.constraint(equalTo: topAnchor),
            blackIndicatorLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            blackIndicatorLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            blackIndicatorLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func setup() {
        // Progress Layer
        progressFillLayer.backgroundColor = UIColor.green.cgColor
        progressMaskLayer.backgroundColor = UIColor.black.cgColor
        
        layer.addSublayer(progressFillLayer)
        
        // White Indicator Label
        whiteIndicatorLabel.font = .systemFont(ofSize: 24, weight: .semibold)
        whiteIndicatorLabel.textColor = .white
        whiteIndicatorLabel.textAlignment = .center
        whiteIndicatorLabel.numberOfLines = 1
        whiteIndicatorLabel.adjustsFontSizeToFitWidth = true
        whiteIndicatorLabel.minimumScaleFactor = 0.5
        
        whiteIndicatorLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(whiteIndicatorLabel)
        
        // Black Indicator Label
        blackIndicatorLabel.font = .systemFont(ofSize: 24, weight: .semibold)
        blackIndicatorLabel.textColor = .black
        blackIndicatorLabel.textAlignment = .center
        blackIndicatorLabel.numberOfLines = 1
        blackIndicatorLabel.adjustsFontSizeToFitWidth = true
        blackIndicatorLabel.minimumScaleFactor = 0.5
        blackIndicatorLabel.layer.mask = progressMaskLayer
        
        blackIndicatorLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(blackIndicatorLabel)
        
        // Self
        backgroundColor = .gray
        layer.cornerRadius = 6
        clipsToBounds = true
    }
}

// MARK: Wrapper
struct UIKitMaskedTextProgressBarWrapper: UIViewRepresentable {
    
    func makeUIView(context: Context) -> UIKitMaskedTextProgressBar {
        UIKitMaskedTextProgressBar()
    }
    
    func updateUIView(_ uiView: UIKitMaskedTextProgressBar, context: Context) {
        
    }
}

// MARK: Preview
#Preview {
    UIKitMaskedTextProgressBarWrapper()
        .aspectRatio(5, contentMode: .fit)
        .padding()
}
