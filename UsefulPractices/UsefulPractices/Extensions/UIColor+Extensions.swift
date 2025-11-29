//
//  UIColor+Extensions.swift
//  UsefulPractices
//
//  Created by Alexandr Zhelanov on 29/11/25.
//

import UIKit

public extension UIColor {
    // MARK: - HEX
    /// rgb = 0xFF8800, where FF = R, 88 = G, 00 = B
    /// 4 + 4 bits for each hex digit, inBinary:
    /// 1111 1111 = R
    /// 1000 1000 = G
    /// 0000 0000 = B
    /// So, to find R we shift 16 bits (shift G and B, so R will be on the right):
    /// 11111111 10001000 00000000 >> 16 = 00000000 00000000 11111111
    /// Then, do mask: rgb & 0xFF (11111111) to keep only last 8 needed bits (if integer more than 24 bits)
    convenience init(hex rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
    convenience init(hex rgbString: String) {
        self.init(
            hex: Int(rgbString, radix: 16) ?? 0
        )
    }
    
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(
            red: CGFloat(red) / 255.0,
            green: CGFloat(green) / 255.0,
            blue: CGFloat(blue) / 255.0,
            alpha: 1.0
        )
    }
}
