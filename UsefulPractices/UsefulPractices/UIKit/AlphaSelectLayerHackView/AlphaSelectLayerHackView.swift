//
//  AlphaSelectLayerHackView.swift
//  UsefulPractices
//
//  Created by Alexandr Zhelanov on 29/11/25.
//

import UIKit
import CoreImage

final class AlphaSelectLayerHackView: UIView {
    // MARK: Properties
    private var baseLayer: CALayer = CALayer()
    private var areasLayers: [HeadArea: CALayer] = [:]
    private var selectedAreas = Set<HeadArea>()
    /// Some property for documentation linking test.
    var documentedProperty: Int = 0
    
    // MARK: Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Layout
    override func layoutSubviews() {
        super.layoutSubviews()
        redrawView()
    }
    
    // MARK: Setup
    private func setupView() {
        // Front Base Layer
        baseLayer.contents = UIImage(named: "head-base")?.cgImage
        
        // Front Areas Layers
        HeadArea.allCases.forEach {
            let layer = CALayer()
            areasLayers[$0] = layer
        }
    }
    
    // MARK: Internal
    private func redrawView() {
        clearLayer()
        
        baseLayer.frame = bounds
        layer.addSublayer(baseLayer)
        
        areasLayers.forEach {
            let isSelected = selectedAreas.contains($0.key)
            var image = UIImage(named: $0.key.rawValue)
            
            if !isSelected {
                image = image?.imageWithColor(UIColor.red.withAlphaComponent(0.2))
            }
            
            $0.value.frame = bounds
            $0.value.contents = image?.cgImage
            layer.addSublayer($0.value)
        }
        setNeedsDisplay()
    }
    
    private func clearLayer() {
        layer.sublayers?.forEach {
            $0.removeFromSuperlayer()
        }
    }
    
    /// HACK: Get the alpha channel of a point on the layer.
    /// If the alpha is zero, it’s blank space — not a needed element.
    /// With this hack, we can avoid drawing the layer’s contents using UIBezierPath, etc., and just load images instead.
    /// 
    /// - Parameter point: The location on layer to get alpha.
    /// - Returns
    private func handleFrontTouch(_ point: CGPoint) {
        for info in areasLayers {
            let layer = info.value
            let alpha = layer.alphaOfPoint(point: point)
            guard alpha > 0 else { continue }
            
            if selectedAreas.contains(info.key) {
                selectedAreas.remove(info.key)
            } else {
                selectedAreas.insert(info.key)
            }
            return
        }
    }
    
    /// Test function for documentation markdown.
    ///
    /// Do nothing and don't affect on ``documentedProperty`` property.
    ///
    /// - Parameters:
    ///     - first: First parameter.
    ///     - second: Second parameter.
    /// - Returns: Some integer.
    func testDocumentationFunction(first: String, second: String) -> Int {
        return 0
    }
    
    // MARK: User Interactivity
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let point = touch.location(in: self)
        
        handleFrontTouch(point)
        redrawView()
    }
}
