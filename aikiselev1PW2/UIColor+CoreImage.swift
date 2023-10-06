//
//  UIColor+CoreImage.swift
//  aikiselev1PW2
//
//  Created by Alexey Kiselev on 06.10.2023.
//

import UIKit

extension UIColor {
    var coreImageColor: CIColor {
        return CIColor(color: self)
    }
    var components: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        let color = coreImageColor
        return (color.red, color.green, color.blue, color.alpha)
    }
}
