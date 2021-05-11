//
//  UIView+Extensions.swift
//  Camping
//
//  Created by Stable 09 on 10.05.2021.
//

import UIKit

extension UIView {
    
    var cornerRadius: CGFloat {
        get {
            self.layer.cornerRadius
        }
        set {
            self.layer.cornerRadius = newValue
        }
    }
    
    func border(color: UIColor, width: CGFloat) {
        layer.borderColor = color.cgColor
        layer.borderWidth = width
    }
    
    func shadow(color: UIColor, size: CGSize) {
        layer.shadowOpacity = 1
        layer.shadowRadius = 0
        layer.shadowOffset = size
        layer.shadowColor = color.cgColor
    }
}
