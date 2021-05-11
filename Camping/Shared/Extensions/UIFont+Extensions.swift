//
//  UIFont+Extensions.swift
//  Camping
//
//  Created by Stable 09 on 10.05.2021.
//

import UIKit

enum FontWeight: String {
    case Black
    case Bold
    case Heavy
    case Light
    case Medium
    case Regular
    case Semibold
    case Thin
    case UltraLight
}

extension UIFont {
    
    class func SFPo(weight: FontWeight, size: CGFloat) -> UIFont {
        UIFont(name: "SF Pro Text \(weight.rawValue)", size: size)!
    }
}
