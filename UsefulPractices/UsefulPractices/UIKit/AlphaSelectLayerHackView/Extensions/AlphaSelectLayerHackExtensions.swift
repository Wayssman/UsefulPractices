//
//  AlphaSelectLayerHackExtensions.swift
//  UsefulPractices
//
//  Created by Alexandr Zhelanov on 29/11/25.
//

import UIKit

extension CALayer {
    func alphaOfPoint(point: CGPoint) -> CGFloat {
        // Store pixel info here
        var pixel: [CUnsignedChar] = [0, 0, 0, 0]

        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)

        let context = CGContext(
            data: &pixel,
            width: 1,
            height: 1,
            bitsPerComponent: 8, // 8 bit (1 byte) for each color component
            bytesPerRow: 4,  // 4 color components RGBA
            space: colorSpace, // RGB color space
            bitmapInfo: bitmapInfo.rawValue  // With alpha last
        )
        /// Move 1x1 context to needed point. Context origin is always 0,0.
        /// So we need to move layer beyond that context (to needed point)/
        context!.translateBy(x: -point.x, y: -point.y)
        // Render layer into context
        self.render(in: context!)

        // Get components of needed CGPoint
        let red = CGFloat(pixel[0]) / 255
        let green = CGFloat(pixel[1]) / 255
        let blue = CGFloat(pixel[2]) / 255
        let alpha = CGFloat(pixel[3]) / 255

        return alpha
    }
}

extension UIImage {
    func imageWithColor(_ color: UIColor) -> UIImage {
        UIGraphicsImageRenderer(size: self.size).image(actions: { context in
            // Translate from UIKit/SwiftUI top-left coordinates to Core Graphics bottom-left
            let cgContext = context.cgContext
            cgContext.translateBy(x: 0, y: self.size.height)
            cgContext.scaleBy(x: 1, y: -1)
            
            // Apply mask of our image to rect
            let rect = CGRect(
                origin: .zero,
                size: .init(
                    width: self.size.width,
                    height: self.size.height
                )
            )
            cgContext.clip(to: rect, mask: self.cgImage!)
            
            // Fills masked rect with color
            color.setFill()
            cgContext.fill(rect)
        })
    }
}
