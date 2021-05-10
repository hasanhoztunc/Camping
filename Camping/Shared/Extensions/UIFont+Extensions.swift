//
//  UIFont+Extensions.swift
//  Camping
//
//  Created by Stable 09 on 10.05.2021.
//

import UIKit

enum FontWeight: String {
    case Bold
    case Heavy
    case Light
    case Medium
    case Regular
    case Semibold
}

extension UIFont {
    
    class func SFPo(weight: FontWeight, size: CGFloat) -> UIFont {
        UIFont(name: "SF-Pro-Text-\(weight)", size: size) ?? UIFont.systemFont(ofSize: size)
    }
}
